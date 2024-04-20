import { getServerSession } from "next-auth/next"

import { authOptions } from "@/lib/auth"
import { User } from "next-auth";

export async function getCurrentUser(): Promise<(User & {   id: string;   username: string; }) | undefined> {
  const session = await getServerSession(authOptions)

  return session?.user
}


