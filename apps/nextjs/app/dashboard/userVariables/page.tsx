import { Metadata } from "next"
import { redirect } from "next/navigation"

import { authOptions } from "@/lib/auth"
import { getCurrentUser } from "@/lib/session"
import { UserVariableAddButton } from "@/components/userVariable/user-variable-add-button"
import { UserVariableList } from "@/components/userVariable/user-variable-list"
import { Shell } from "@/components/layout/shell"
import { DashboardHeader } from "@/components/pages/dashboard/dashboard-header"


export const metadata: Metadata = {
  title: "Your Variables",
  description: "Manage your treatments, symptoms, and other variables.",
}

export default async function UserVariablesPage() {
  const user = await getCurrentUser()

  if (!user) {
    redirect(authOptions?.pages?.signIn || "/signin")
  }

  // Define search parameters
  const searchParams = {
    includePublic: true,
    sort: 'createdAt',
    limit: 10,
    offset: 0,
    searchPhrase: "mood",
  };

  return (
    <Shell>
      <DashboardHeader heading="Your Variables" text="Manage your treatments, symptoms, and other variables.">
        <UserVariableAddButton />
      </DashboardHeader>
      <UserVariableList user={user} searchParams={searchParams} />
    </Shell>
  )
}
