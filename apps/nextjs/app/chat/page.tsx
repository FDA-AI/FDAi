import { Metadata } from "next"
import { redirect } from "next/navigation"

import { authOptions } from "@/lib/auth"
import { getCurrentUser } from "@/lib/session"
import { Shell } from "@/components/layout/shell"
import { DashboardHeader } from "@/components/pages/dashboard/dashboard-header"
import ChatComponent from '@/components/chat-component';

export const metadata: Metadata = {
  title: "Chat",
  description: "Monitor your progress.",
}

interface DashboardProps {
  searchParams: { from: string; to: string }
}

export default async function Dashboard({ searchParams }: DashboardProps) {
  const user = await getCurrentUser()

  if (!user) {
    redirect(authOptions?.pages?.signIn || "/signin")
  }


  const layout = "grid grid-cols-1 gap-4 md:grid-cols-2";

  return (
    <Shell>
      <DashboardHeader heading="Your Data" text="Monitor your symptoms and factors.">
      </DashboardHeader>
      <div className={layout}>
        <ChatComponent></ChatComponent>
      </div>
    </Shell>
  )
}
