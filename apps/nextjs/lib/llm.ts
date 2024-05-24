import OpenAI from 'openai';
import {convertToLocalDateTime} from "@/lib/dateTimeWithTimezone";
// Create an OpenAI API client (that's edge-friendly!)
const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY || '',
});

export async function textCompletion(promptText: string, returnType: "text" | "json_object"): Promise<string> {

  // Ask OpenAI for a streaming chat completion given the prompt
  const response = await openai.chat.completions.create({
    model: 'gpt-4-turbo',
    stream: false,
    //max_tokens: 150,
    messages: [
      {
        role: "system",
        content: `You are a helpful assistant that translates user requests into JSON objects`
      },
      {
        role: "user", // user = the dFDA app
        content: promptText
      },

    ],
    response_format: { type: returnType },
  });

  if(!response.choices[0].message.content) {
    throw new Error('No content in response');
  }

  return response.choices[0].message.content;
}

export async function getDateTimeFromStatementInUserTimezone(statement: string,
                                                             utcDateTime: string,
                                                             timeZoneOffset: number): Promise<string> {
  const localDateTime = convertToLocalDateTime(utcDateTime, timeZoneOffset);
  const promptText = `
        estimate the date and time of the user statement based on the user's current date and time ${localDateTime}
         and the following user statement:
\`\`\`
${statement}
\`\`\`
       Return a single string in the format "YYYY-MM-DDThh:mm:ss"`;
  let result = await textCompletion(promptText, "text");
  // Remove quote marks
  result = result.replace(/['"]+/g, '');
  return result;
}
