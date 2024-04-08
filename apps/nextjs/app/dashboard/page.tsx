import { Metadata } from "next"
import { redirect } from "next/navigation"

import { authOptions } from "@/lib/auth"
import { getCurrentUser } from "@/lib/session"
import { ScrollArea } from "@/components/ui/scroll-area"
import { measurementColumns } from "@/components/userVariable/measurements/measurements-columns"

import { DataTable } from "@/components/data-table"
import { Shell } from "@/components/layout/shell"
import { DashboardHeader } from "@/components/pages/dashboard/dashboard-header"
import { UserVariableList } from '@/components/userVariable/user-variable-list';

export const metadata: Metadata = {
  title: "Dashboard",
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
  const scrollClass =  "h-[17rem] rounded-lg border";

  return (
    <Shell>
      <DashboardHeader heading="Your Data" text="Monitor your symptoms and factors.">
      </DashboardHeader>
      <div className={layout}>
        <ScrollArea className={scrollClass}>
          <div className="divide-y divide-border">
            <UserVariableList />
          </div>
        </ScrollArea>
      </div>
    </Shell>
  )
}
