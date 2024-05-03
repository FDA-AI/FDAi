import { NextRequest, NextResponse } from 'next/server';
import { conversation2measurements } from "@/lib/conversation2measurements";
import {postMeasurements} from "@/lib/dfda";
import {getUserId} from "@/lib/getUserId";
import {handleError} from "@/lib/errorHandler";

export async function POST(request: NextRequest) {
  let { statement, utcDateTime, timeZoneOffset, previousStatements } = await request.json();

try {
  const measurements = await conversation2measurements(statement, utcDateTime, timeZoneOffset, previousStatements);
  const userId = await getUserId();
  if(userId){
    await postMeasurements(measurements, userId)
  }
    return NextResponse.json({ success: true, measurements: measurements });
  } catch (error) {
    return handleError(error, "conversation2measurements")
  }
}

export async function GET(req: NextRequest) {
  const urlParams = Object.fromEntries(new URL(req.url).searchParams);
  const statement = urlParams.statement as string;
  const previousStatements = urlParams.previousStatements as string | null | undefined;
  let timeZoneOffset;
  if(urlParams.timeZoneOffset){timeZoneOffset = parseInt(urlParams.timeZoneOffset);}
  const utcDateTime = urlParams.utcDateTime as string | null | undefined;

  try {
    const measurements = await conversation2measurements(statement, utcDateTime, timeZoneOffset, previousStatements);
    const userId = await getUserId();
    if(userId){await postMeasurements(measurements, userId)}
    return NextResponse.json({ success: true, measurements: measurements });
  } catch (error) {
    return handleError(error, "conversation2measurements")
  }
}
