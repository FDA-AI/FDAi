import { NavBar } from '@/app/(frontpage)/components/nav-bar'
import { GradientBlur } from '@/app/(frontpage)/components/gradient-blur'
import { Footer } from '@/app/(frontpage)/components/footer'
import { MissionSection } from '@/app/(frontpage)/components/mission-section'
import { ChallengeSection } from '@/app/(frontpage)/components/challenge-section'
import { SolutionSection } from '@/app/(frontpage)/components/solution-section'
import { JoinSection } from '@/app/(frontpage)/components/join-section'
import { ImpactSection } from '@/app/(frontpage)/components/impact-section'
import { TimelineSection } from '@/app/(frontpage)/components/timeline-section'
import { ResourcesSection } from '@/app/(frontpage)/components/resources-section'
import { DiagramSection } from './components/diagram-section'

export default function CureDaoHome() {
  return (
    <main className="min-h-screen bg-[#13111a] overflow-hidden">
      <NavBar />
      <MissionSection />

      <div className="relative">
        <GradientBlur
          className="absolute right-[10vw] w-[60vw] h-[60vh] -translate-y-1/2"
          variant="default"
        />
        <DiagramSection />
      </div>


      <div className="relative">
        <GradientBlur
          className="absolute right-[10vw] w-[60vw] h-[60vh] -translate-y-1/2"
          variant="default"
        />
        <ChallengeSection />
      </div>

      <div className="relative">
        <GradientBlur
          className="absolute left-[5vw] w-[50vw] h-[60vh] -translate-y-1/4"
          variant="blue-purple"
          rotationDelay="-7s"
        />
        <SolutionSection />
      </div>

      <div className="relative">
        <GradientBlur
          className="absolute right-[5vw] w-[55vw] h-[65vh] -translate-y-1/3"
          variant="default"
          rotationDelay="-12s"
        />
        <JoinSection />
      </div>

      <div className="relative">
        <GradientBlur
          className="absolute left-[10vw] w-[60vw] h-[70vh] -translate-y-1/2"
          variant="blue-purple"
          rotationDelay="-18s"
        />
        <ImpactSection />
      </div>

      <div className="relative">
        <GradientBlur
          className="absolute right-[15vw] w-[50vw] h-[60vh] -translate-y-1/4"
          variant="default"
          rotationDelay="-24s"
        />
        <TimelineSection />
      </div>

      <div className="relative">
        <GradientBlur
          className="absolute left-[20vw] w-[55vw] h-[65vh] -translate-y-1/3"
          variant="blue-purple"
          rotationDelay="-30s"
        />
        <ResourcesSection />
      </div>

      <Footer />
    </main>
  )
}

