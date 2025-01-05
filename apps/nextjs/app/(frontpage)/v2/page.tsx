import { NavBar } from '@/app/(frontpage)/components/nav-bar'
import { HeroSection } from '@/app/(frontpage)/components/hero-section'
import { PillarsSection } from '@/app/(frontpage)/components/pillars-section'
import { WhyNowSection } from '@/app/(frontpage)/components/why-now-section'
import { MetricsSection } from '@/app/(frontpage)/components/metrics-section'
import { JoinSection } from '@/app/(frontpage)/components/join-section'
import { GradientBlur } from '@/app/(frontpage)/components/gradient-blur'
import { Footer } from '@/app/(frontpage)/components/footer'
import {ImprovedFDASection} from "@/app/(frontpage)/components/improved-fda-section";

export default function CureDAOHomeV2() {
  return (
      <main className="min-h-screen bg-[#13111a] overflow-hidden">
          <NavBar/>
          <HeroSection/>

          <div className="relative">
              <GradientBlur
                  className="absolute right-[10vw] w-[60vw] h-[60vh] -translate-y-1/2"
                  variant="default"
              />
              <PillarsSection/>
          </div>

          <div className="relative">
              <GradientBlur
                  className="absolute right-[10vw] w-[60vw] h-[60vh] -translate-y-1/2"
                  variant="default"
              />
              <ImprovedFDASection/>
          </div>

          <div className="relative">
              <GradientBlur
                  className="absolute left-[5vw] w-[50vw] h-[60vh] -translate-y-1/4"
                  variant="blue-purple"
                  rotationDelay="-7s"
              />
              <WhyNowSection/>
          </div>

          <div className="relative">
              <GradientBlur
                  className="absolute right-[5vw] w-[55vw] h-[65vh] -translate-y-1/3"
                  variant="default"
                  rotationDelay="-12s"
              />
              <MetricsSection/>
          </div>

          <div className="relative">
              <GradientBlur
                  className="absolute left-[10vw] w-[60vw] h-[70vh] -translate-y-1/2"
                  variant="blue-purple"
                  rotationDelay="-18s"
              />
              <JoinSection/>
          </div>

          <Footer/>
      </main>
  )
}

