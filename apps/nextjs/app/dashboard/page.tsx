import { Metadata } from "next"
import { redirect } from "next/navigation"

import { authOptions } from "@/lib/auth"
import { getCurrentUser } from "@/lib/session"

import { Shell } from "@/components/layout/shell"
import { DashboardHeader } from "@/components/pages/dashboard/dashboard-header"
import {UserVariableSearch} from "@/components/userVariable/user-variable-search";

export const metadata: Metadata = {
  title: "Dashboard",
  description: "Monitor your progress.",
}



export default async function Dashboard() {
  const user = await getCurrentUser()

  if (!user) {
    redirect(authOptions?.pages?.signIn || "/signin")
  }


  const layout = "gap-4";

  return (
    <Shell>
      <DashboardHeader heading="Your Data" text="Monitor your symptoms and factors.">
      </DashboardHeader>
      <div className={layout}>
         <UserVariableSearch user={user}/>
      </div>
    </Shell>
  )
}
