# Text2Measurements - Diet, Treatment, and Symptom Tracking with NLP

This library provides a way to convert natural language inputs into structured data about diet, treatment, and symptom tracking. It parses the user input, and can handle a wide range of inputs related to what the user ate, what treatments they took, and how severe their symptoms were.

## Features

- Converts complex linguistic inputs into a structured JSON format.
- Handles a variety of measurement units and variable categories.
- Can handle a wide range of diet, treatment, and symptom tracking statements.

## Installation

Clone this repository and navigate to the project root. Install the dependencies with npm:

```bash
yarn install
```

## Usage

### Processing a Single Statement

```typescript
import { processStatement } from './text-2-measurements';
const result = await processStatement("I ate a bowl of oatmeal for breakfast.");
```

### Processing Multiple Statements

```typescript
import { processStatements } from './text-2-measurements';
const results = await processStatements([
  "I ate a bowl of oatmeal for breakfast.",
  "Took 500mg of Paracetamol at 10 AM.",
  "Experienced a headache around midday, severity was 3 out of 5."
]);
```

## Testing

To run the tests, execute:

```bash
npm run test
```


