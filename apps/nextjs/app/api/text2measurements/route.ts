import { NextRequest, NextResponse } from 'next/server';
import {MeasurementSet} from "@/app/api/text2measurements/measurementSchema";
import {createJsonTranslator, createLanguageModel} from "typechat";
import fs from "fs";
import path from "path";

const model = createLanguageModel(process.env);
let viewSchema = fs.readFileSync(
  path.join(__dirname, "measurementSchema.ts"),
  "utf8"
);

async function processStatement(statement: string, localDateTime?: string): Promise<MeasurementSet> {
    if (localDateTime) {
      viewSchema += "\n// Use the current local datetime " + localDateTime +
        " to determine startDateLocal. If specified, also determine startTimeLocal, endDateLocal, and endTimeLocal or just leave them null.";
    }
    const translator = createJsonTranslator(model, viewSchema, "MeasurementSet");
    const response = await translator.translate(statement);
    if (!response.success) {
      console.error(response);
      throw new Error("Translation failed");
    }
    const measurementSet = response.data as MeasurementSet;
    if (measurementSet.measurements.some((item) => item.itemType === "unknown")) {
      console.log("I didn't understand the following:");
      for (const item of measurementSet.measurements) {
        if (item.itemType === "unknown") console.log(item.text);
      }
    }
    return measurementSet;
  }

export async function POST(request: NextRequest) {
  // Logging the start of the image processing API call
  console.log('Starting the image processing API call');

  // Extracting the file (in base64 format) and an optional custom prompt
  // from the request body. This is essential for processing the image using OpenAI's API.
  const {  prompt} = await request.json();

  // Log the receipt of the image in base64 format
try {
    // Process the statement to extract measurements
  const measurements = await  processStatement(prompt);

    // Return the analysis in the response
    return NextResponse.json({ success: true, measurements: measurements });
  } catch (error) {
    // Log and handle any errors encountered during the request to OpenAI
    console.error('Error sending request to OpenAI:', error);
    return NextResponse.json({ success: false, message: 'Error sending request to OpenAI' });
  }
}
