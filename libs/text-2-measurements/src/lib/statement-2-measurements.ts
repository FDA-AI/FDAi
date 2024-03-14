import * as fs from "fs";
import * as path from "path";
import { config } from "dotenv";
import {
  createLanguageModel,
  createJsonTranslator
} from "typechat";
import { Measurement } from "./measurementSchema";
import { MeasurementSet } from "./measurementSchema";
function findEnvFile(startPath: string): string | null {
  let currentPath = startPath;

  while (currentPath !== path.parse(currentPath).root) {
    const envPath = path.join(currentPath, '.env');
    if (fs.existsSync(envPath)) {
      return envPath;
    }
    currentPath = path.dirname(currentPath);
  }

  return null;
}

const envPath = findEnvFile(__dirname);
if (envPath) {
  config({ path: envPath });
} else {
  throw Error('.env file not found');
}

const model = createLanguageModel(process.env);
let viewSchema = fs.readFileSync(
  path.join(__dirname, "measurementSchema.ts"),
  "utf8"
);

export async function processStatement(statement: string, localDateTime?: Date|string|undefined): Promise<MeasurementSet> {
  if(localDateTime) {
    viewSchema += "\n// The current local datetime is " + localDateTime + ".";
  }
  const translator =
    createJsonTranslator<MeasurementSet>(model, viewSchema, "MeasurementSet");
  const response = await translator.translate(statement);
  if (!response.success) {
    console.log(response);
    return null;
  }
  const measurementSet = response.data;
  if (measurementSet.measurements.some((item) => item.itemType === "unknown")) {
    console.log("I didn't understand the following:");
    for (const item of measurementSet.measurements) {
      if (item.itemType === "unknown") console.log(item.text);
    }
  }
  printMeasurementSet(measurementSet);
  return measurementSet;
}

async function processStatements(statements: string[]): Promise<MeasurementSet[]> {
  const measurementSets: MeasurementSet[] = [];
  for (const statement of statements) {
    const measurementSet = await processStatement(statement);
    if (measurementSet) {
      measurementSets.push(measurementSet);
    }
  }
  return measurementSets;
}

function printMeasurementSet(measurementSet: MeasurementSet) {
  function isMeasurement(object: any): object is Measurement {
    return 'items' in object;
  }
  if (measurementSet.measurements && measurementSet.measurements.length > 0) {
    for (const measurement of measurementSet.measurements) {
      if(isMeasurement(measurement)) {
        const s = `
        ${measurement.value} ${measurement.unitName} ${measurement.variableName}
         ${measurement.startTimeLocal} ${measurement.variableCategoryName}`;
        console.log(s);
        continue;
      }
      console.log(measurement);
    }
  }
}

// Example usage:
// const singleMeasurementSet = await processStatement("I ate a bowl of oatmeal for breakfast.");
// const multipleMeasurementSets = await processStatements([
//                                                           "I ate a bowl of oatmeal for breakfast.",
//                                                           "Took 500mg of Paracetamol at 10 AM.",
//                                                           "Experienced a headache around midday, severity was 3 out of 5."
//                                                         ]);
