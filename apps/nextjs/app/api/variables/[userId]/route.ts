import { getServerSession } from "next-auth/next"
import { z } from "zod"

import { authOptions } from "@/lib/auth"
import {handleError} from "@/lib/errorHandler";
import { getOrCreateDfdaAccessToken } from "@/lib/dfdaUserService";

const routeContextSchema = z.object({
  params: z.object({
    userId: z.string(),
  }),
})

export async function GET(req: Request, context: z.infer<typeof routeContextSchema>) {

  try {
    const { params } = routeContextSchema.parse(context);
    const session = await getServerSession(authOptions);

    if (!session?.user || params.userId !== session?.user.id) {
      return new Response(null, { status: 403 });
    }

    const url = new URL(req.url, `http://${req.headers.get("host")}`);
    const dfdaParams = url.searchParams;

    const response = await fetch(`https://safe.dfda.earth/api/v3/variables?${dfdaParams}`, {
      method: 'GET',
      headers: {
        'accept': 'application/json',
        'Authorization': `Bearer ${await getOrCreateDfdaAccessToken(params.userId)}`,
      },
      credentials: 'include'
    });
    const data = await response.json();
    return data;
  } catch (error) {
    return handleError(error);
  }
}
