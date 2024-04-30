import { Metadata } from "next"
import { redirect } from "next/navigation"

import { authOptions } from "@/lib/auth"
import { getCurrentUser } from "@/lib/session"
import { GlobalVariableAddButton } from "@/components/globalVariables/global-variable-add-button"
import { Shell } from "@/components/layout/shell"
import { DashboardHeader } from "@/components/pages/dashboard/dashboard-header"
import {GenericVariableList} from "@/components/genericVariables/generic-variable-list";


export const metadata: Metadata = {
  title: "Your Variables",
  description: "Manage your treatments, symptoms, and other variables.",
}

export default async function GlobalVariablesPage() {
  const user = await getCurrentUser()

  if (!user) {
    redirect(authOptions?.pages?.signIn || "/signin")
  }

  // Define search parameters
  const searchParams = {
    includePublic: false,
    sort: 'createdAt',
    limit: 10,
    offset: 0,
    searchPhrase: "",
  };

  return (
    <Shell>
      <DashboardHeader heading="Your Variables" text="Manage your treatments, symptoms, and other variables.">
        <GlobalVariableAddButton />
      </DashboardHeader>
      <GenericVariableList user={user} searchParams={searchParams} />
    </Shell>
  )
}
