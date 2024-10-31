import { NextRequest, NextResponse } from 'next/server';
import {handleError} from "@/lib/errorHandler";
import { haveConversation } from '@/lib/conversation2measurements';
import { text2measurements } from '@/lib/text2measurements';

export async function POST(request: NextRequest) {
  let { statement, utcDateTime, timeZoneOffset, text, previousStatements, previousQuestions } = await request.json();

  if(!statement){statement = text;}
   //TODO: replace previous statements properly
  try {
    //const measurements = await text2measurements(statement, utcDateTime, timeZoneOffset);
    //haveConversation
    //input: statement, utcDateTime, timeZoneOffset, previousStatements)
    //output: questionForUser, measurements
    const { questionForUser } = await haveConversation(statement, utcDateTime, timeZoneOffset, previousStatements, previousQuestions);
    const measurements = text2measurements(statement, utcDateTime, timeZoneOffset);
    return NextResponse.json({ success: true, question:questionForUser });
  } catch (error) {
    return handleError(error, "voice2measurements")
  }
}
