import Link from "next/link"

import { navLinks } from "@/config/links"
import { siteConfig } from "@/config/site"

import { ModeToggle } from "../mode-toggle"

export default function Footer() {
  return (
    <footer className="mt-auto">
      <div className="mx-auto w-full max-w-screen-xl p-2 md:py-2">
        <hr className="my-6 text-muted-foreground sm:mx-auto" />
        <div className="flex items-center justify-center p-2">
          <div className="sm:flex sm:items-center sm:justify-between">
            <ul className="mb-8 flex flex-wrap items-center opacity-60 sm:mb-0">
              {navLinks.data.map((item, index) => {
                return (
                  item.href && (
                    <li key={index}>
                      <Link
                        href={item.disabled ? "/" : item.href}
                        className="mr-4 hover:underline md:mr-6"
                      >
                        {item.title}
                      </Link>
                    </li>
                  )
                )
              })}
            </ul>
          </div>
        </div>
        <div id="copyright" className="flex items-center justify-center p-4">
          <div className="block text-sm text-muted-foreground sm:text-center">
            © {new Date().getFullYear()}{" "}
            <a
              target="_blank"
              href="https://github.com/decentralized-fda"
              className="hover:underline"
            >
              {siteConfig.name}
            </a>
            . Your Rights to Self-Experimentation Reserved.
          </div>
        </div>
      </div>
    </footer>
  )
}
