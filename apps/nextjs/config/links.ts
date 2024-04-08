import { Navigation } from "@/types"

export const navLinks: Navigation = {
  data: [
    {
      title: "Home",
      href: "/",
    },
    {
      title: "Dashboard",
      href: "/dashboard",
    },
  ],
}

export const dashboardLinks: Navigation = {
  data: [
    {
      title: "Dashboard",
      href: "/dashboard",
      icon: "dashboard",
    },
    {
      title: "Variables",
      href: "/dashboard/userVariables",
      icon: "activity",
    },
    {
      title: "Measurements",
      href: "/dashboard/measurements",
      icon: "measurement",
    },
    {
      title: "Profile",
      href: "/dashboard/settings",
      icon: "settings",
    },
  ],
}
