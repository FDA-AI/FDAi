import { NextRequest, NextResponse } from 'next/server';
import {handleError} from "@/lib/errorHandler";
import { haveConversation } from '@/lib/conversation2measurements';
import { text2measurements } from '@/lib/text2measurements';

export async function POST(request: NextRequest) {
  let { statement, utcDateTime, timeZoneOffset, text, previousStatements, previousQuestions } = await request.json();

  if(!statement){statement = text;}
  try {
    const { questionForUser } = await haveConversation(statement, utcDateTime, timeZoneOffset, previousStatements, previousQuestions);
    text2measurements(statement, utcDateTime, timeZoneOffset);
    return NextResponse.json({ success: true, question:questionForUser });
  } catch (error) {
    return handleError(error, "voice2measurements")
  }
}
