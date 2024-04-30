import { Metadata } from "next"
import { redirect } from "next/navigation"

import { authOptions } from "@/lib/auth"
import { getCurrentUser } from "@/lib/session"

import { Shell } from "@/components/layout/shell"
import { DashboardHeader } from "@/components/pages/dashboard/dashboard-header"
import {GenericVariableSearch} from "@/components/genericVariables/generic-variable-search";

export const metadata: Metadata = {
  title: "Dashboard",
  description: "Record your treatments and symptom.",
}

export default async function Dashboard() {
  const user = await getCurrentUser()

  if (!user) {
    redirect(authOptions?.pages?.signIn || "/signin")
  }


  const layout = "gap-4";

  return (
    <Shell>
      <DashboardHeader heading="Variables" text="Record measurements, add reminders or view your measurement history">
      </DashboardHeader>
      <div className={layout}>
         <GenericVariableSearch user={user}/>
      </div>
    </Shell>
  )
}
