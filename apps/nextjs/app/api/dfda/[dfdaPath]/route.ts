import { getServerSession } from 'next-auth/next';
import { z } from 'zod';

import { authOptions } from '@/lib/auth';
import { handleError } from '@/lib/errorHandler';
import {dfdaGET, dfdaPOST} from '@/lib/dfda';

const routeContextSchema = z.object({
  params: z.object({
    dfdaPath: z.string(),
  }),
})

export async function GET(req: Request, context: z.infer<typeof routeContextSchema>) {
  const { params } = routeContextSchema.parse(context);
  const urlParams = Object.fromEntries(new URL(req.url).searchParams);
  const session = await getServerSession(authOptions);
  try {
    const response = await dfdaGET(params.dfdaPath, urlParams, session?.user.id);
    const data = response.data ?? response;
    return new Response(JSON.stringify(data), { status: 200, headers: { 'Content-Type': 'application/json' } });
  } catch (error) {
    return handleError(error);
  }
}

export async function POST(req: Request, context: z.infer<typeof routeContextSchema>) {
  const { params } = routeContextSchema.parse(context);
  const urlParams = Object.fromEntries(new URL(req.url).searchParams);
  const body = await req.json();
  const session = await getServerSession(authOptions);
  try {
    const response = await dfdaPOST(params.dfdaPath, body, session?.user.id, urlParams);
    const data = response.data ?? response;
    return new Response(JSON.stringify(data), { status: response.status, headers: { 'Content-Type': 'application/json' } });
  } catch (error) {
    return handleError(error);
  }
}
