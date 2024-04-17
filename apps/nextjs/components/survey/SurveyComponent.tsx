// components/survey/index.tsx
import React from "react"
import * as Survey from "survey-react" // import surveyjs
import { questions } from "./content" // these are the survey questions
import { Container } from "./styles" // your styles here

// Modern theme
import "survey-react/modern.min.css"
// Default theme
// import 'survey-react/survey.min.css';

const SurveyComponent = () => {
  // Apply theme
  Survey.StylesManager.applyTheme("modern")

  // Create a modal
  const survey = new Survey.Model(questions)

  // Render the survey
  return (
    <Container className="container">
      <Survey.Survey model={survey} />
    </Container>
  )
}

export default SurveyComponent