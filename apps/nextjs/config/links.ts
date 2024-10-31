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
      title: "Image 2 Measurements",
      href: "/dashboard/image2measurements",
      icon: "camera",
    },
    {
      title: "Text 2 Measurements",
      href: "/dashboard/text2measurements",
      icon: "write",
    },
    {
      title: "Voice 2 Measurements",
      href: "/dashboard/voice2measurements",
      icon: "write",
    },
    {
      title: "New page : Voice 2 Measurements",
      href: "/dashboard/newvoice2measurements",
      icon: "write",
    },
    {
      title: "Profile",
      href: "/dashboard/settings",
      icon: "settings",
    },
  ],
}
