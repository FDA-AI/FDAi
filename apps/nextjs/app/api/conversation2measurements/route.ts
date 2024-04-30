import { NextRequest, NextResponse } from 'next/server';
import { conversation2measurements } from "@/lib/conversation2measurements";
import {postMeasurements} from "@/lib/dfda";
import {getUserId} from "@/lib/getUserId";

export async function POST(request: NextRequest) {
  let { statement, localDateTime, previousStatements } = await request.json();

try {
  const measurements = await conversation2measurements(statement, localDateTime, previousStatements);
  const userId = await getUserId();
  if(userId){
    await postMeasurements(measurements, userId)
  }
    return NextResponse.json({ success: true, measurements: measurements });
  } catch (error) {
    console.error('Error in conversation2measurements:', error);
    return NextResponse.json({ success: false, message: 'Error in conversation2measurements' });
  }
}

export async function GET(req: NextRequest) {
  const urlParams = Object.fromEntries(new URL(req.url).searchParams);
  const statement = urlParams.statement as string;
  const previousStatements = urlParams.previousStatements as string | null | undefined;
  const localDateTime = urlParams.localDateTime as string | null | undefined;

  try {
    const measurements = await conversation2measurements(statement, localDateTime, previousStatements);
    const userId = await getUserId();
    if(userId){await postMeasurements(measurements, userId)}
    return NextResponse.json({ success: true, measurements: measurements });
  } catch (error) {
    console.error('Error sending request to OpenAI:', error);
    return NextResponse.json({ success: false, message: 'Error sending request to OpenAI' });
  }
}
