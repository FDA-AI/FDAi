import React from "react"
import dynamic from "next/dynamic"
import styled from "styled-components"
const SurveyComponent = dynamic(() => import("../components/survey"), {
  ssr: false,
})
const Container = styled.div`
  margin: 2rem;
`
const Survey = () => {
  return (
    <Container>
      <SurveyComponent />
    </Container>
  )
}
export default Survey
