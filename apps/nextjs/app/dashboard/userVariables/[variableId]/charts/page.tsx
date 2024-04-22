import { Metadata } from "next"
import { notFound, redirect } from "next/navigation"

import { authOptions } from "@/lib/auth"
import { getCurrentUser } from "@/lib/session"
import { Shell } from "@/components/layout/shell"
import { DashboardHeader } from "@/components/pages/dashboard/dashboard-header"
import { UserVariableCharts } from '@/components/userVariable/user-variable-charts';

export const metadata: Metadata = {
  title: "UserVariable Charts",
}

interface UserVariableEditProps {
  params: { variableId: string }
}

export default async function UserVariableChart({ params }: UserVariableEditProps) {
  const user = await getCurrentUser()

  if (!user) {
    redirect(authOptions?.pages?.signIn || "/signin")
  }

  const response = await fetch(
    `/api/dfda/userVariables?variableId=${params.variableId}&includeCharts=true`)
  const userVariables = await response.json()
  const userVariable = userVariables[0]

  if (!userVariable) {
    notFound()
  }

  return (
    <Shell>
      <DashboardHeader
        heading="UserVariable Settings"
        text="Modify userVariable details."
      />
      <div className="grid grid-cols-1 gap-10">
        <UserVariableCharts
          userVariable={userVariable}
        />
      </div>
    </Shell>
  )
}
