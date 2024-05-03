// lib/errorHandler.ts
import {z} from "zod";
import {env} from "@/env.mjs";

export function handleError(error: unknown, context?: string) {
  if(!context){
    context = 'handleError'
  }
    if (error instanceof z.ZodError) {
        return new Response(JSON.stringify(error.issues), {
            status: 422,
            headers: { "Content-Type": "application/json" },
        })
    }

    console.error(context+": ", error)

    if (env.NODE_ENV === "development") {
        return new Response(
            JSON.stringify({ error: "Internal Server Error", details: error }),
            {
                status: 500,
                headers: { "Content-Type": "application/json" },
            }
        )
    } else {
        return new Response(
            JSON.stringify({ error: "Internal Server Error" }),
            {
                status: 500,
                headers: { "Content-Type": "application/json" },
            }
        )
    }
}
