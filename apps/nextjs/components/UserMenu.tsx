// UserMenu.tsx
import React from 'react';
import { Popover, PopoverTrigger, PopoverContent } from "@/components/ui/popover";
import { Button } from "@/components/ui/button";
import Link from "next/link";
import { User } from 'next-auth';
export const UserMenu = ({user}: {user: User}) => {
  return (
    <Popover>
      <PopoverTrigger asChild>
        <Button className="rounded-full w-8 h-8 border-2 border-gray-100" size="icon" variant="ghost">
        <img
          alt="Avatar"
          className="rounded-full"
          height="32"
          src={user.image || "/placeholder.svg"}
          style={{
            aspectRatio: "32/32",
            objectFit: "cover",
          }}
          width="32"
        />
          <span className="sr-only">Toggle user menu</span>
        </Button>
      </PopoverTrigger>
      <PopoverContent className="mt-1 w-56">
        <div>
          <Link
            className="group flex items-center w-full px-3 py-1.5 text-sm rounded-md transition-colors hover:bg-gray-100 hover:text-gray-900 dark:hover:bg-gray-800 dark:hover:text-gray-50"
            href="#"
          >
            <UserIcon className="w-4 h-4 mr-2" />
            Your Profile
          </Link>
        </div>
        <div>
          <Link
            className="group flex items-center w-full px-3 py-1.5 text-sm rounded-md transition-colors hover:bg-gray-100 hover:text-gray-900 dark:hover:bg-gray-800 dark:hover:text-gray-50"
            href="#"
          >
            <CogIcon className="w-4 h-4 mr-2" />
            Settings
          </Link>
        </div>
        <div />
        <div>
          <Link
            className="group flex items-center w-full px-3 py-1.5 text-sm rounded-md transition-colors hover:bg-gray-100 hover:text-gray-900 dark:hover:bg-gray-800 dark:hover:text-gray-50"
            href="/logout"
          >
            <LogOutIcon className="w-4 h-4 mr-2" />
            Logout
          </Link>
        </div>
      </PopoverContent>
    </Popover>
  );
};

function UserIcon(props) {
  return (
    <svg
      {...props}
      xmlns="http://www.w3.org/2000/svg"
      width="24"
      height="24"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="2"
      strokeLinecap="round"
      strokeLinejoin="round"
    >
      <path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2" />
      <circle cx="12" cy="7" r="4" />
    </svg>
  )
}


function CogIcon(props) {
  return (
    <svg
      {...props}
      xmlns="http://www.w3.org/2000/svg"
      width="24"
      height="24"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="2"
      strokeLinecap="round"
      strokeLinejoin="round"
    >
      <path d="M12 20a8 8 0 1 0 0-16 8 8 0 0 0 0 16Z" />
      <path d="M12 14a2 2 0 1 0 0-4 2 2 0 0 0 0 4Z" />
      <path d="M12 2v2" />
      <path d="M12 22v-2" />
      <path d="m17 20.66-1-1.73" />
      <path d="M11 10.27 7 3.34" />
      <path d="m20.66 17-1.73-1" />
      <path d="m3.34 7 1.73 1" />
      <path d="M14 12h8" />
      <path d="M2 12h2" />
      <path d="m20.66 7-1.73 1" />
      <path d="m3.34 17 1.73-1" />
      <path d="m17 3.34-1 1.73" />
      <path d="m11 13.73-4 6.93" />
    </svg>
  )
}


function LogOutIcon(props) {
  return (
    <svg
      {...props}
      xmlns="http://www.w3.org/2000/svg"
      width="24"
      height="24"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="2"
      strokeLinecap="round"
      strokeLinejoin="round"
    >
      <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4" />
      <polyline points="16 17 21 12 16 7" />
      <line x1="21" x2="9" y1="12" y2="12" />
    </svg>
  )
}
