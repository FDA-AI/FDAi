import { getServerSession } from 'next-auth/next';
import { z } from 'zod';

import { authOptions } from '@/lib/auth';
import { handleError } from '@/lib/errorHandler';
import { getOrCreateDfdaAccessToken } from '@/lib/dfda';

const routeContextSchema = z.object({
  params: z.object({
    dfdaPath: z.string(),
  }),
})

// Utility function to reduce duplication
async function fetchDfdaApi(req: Request, method: 'GET' | 'POST', context: z.infer<typeof routeContextSchema>) {
  try {
    const { params } = routeContextSchema.parse(context);
    const session = await getServerSession(authOptions);

    if (!session?.user) {
      return new Response(null, { status: 403 });
    }

    const url = new URL(req.url, `http://${req.headers.get("host")}`);
    const dfdaParams = url.searchParams;
    let dfdaUrl = `https://safe.dfda.earth/api/v3/${params.dfdaPath}?${dfdaParams}`;

    const init: RequestInit = {
      method: method,
      headers: {
        'accept': 'application/json',
        'Authorization': `Bearer ${await getOrCreateDfdaAccessToken(session?.user.id)}`,
        'Content-Type': method === 'POST' ? 'application/json' : undefined,
      } as HeadersInit,
      credentials: 'include',
    };

    if (method === 'POST') {
      const requestBody = await req.json();
      init.body = JSON.stringify(requestBody);
    }

    const response = await fetch(dfdaUrl, init);
    const data = await response.json();
    console.log("Response data:", data);
    return new Response(JSON.stringify(data), { status: 200, headers: { 'Content-Type': 'application/json' } })
  } catch (error) {
    return handleError(error);
  }
}

export async function GET(req: Request, context: z.infer<typeof routeContextSchema>) {
  return fetchDfdaApi(req, 'GET', context);
}

export async function POST(req: Request, context: z.infer<typeof routeContextSchema>) {
  return fetchDfdaApi(req, 'POST', context);
}
