import { useSession } from "next-auth/react";

export function useUserLoggedIn() {
  const { data: session } = useSession();
  return !!session;
}

export function getUser() {
  const { data: session } = useSession();
  return session?.user;
}
