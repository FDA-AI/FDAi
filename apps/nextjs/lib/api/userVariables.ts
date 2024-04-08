import { getServerSession } from 'next-auth';

import { authOptions } from '@/lib/auth';
import { db } from '@/lib/db';
import { GET } from '@/app/api';


// Fetch user's userVariable
export async function getUserVariable(
  variableId: number,
  includeCharts: boolean = false
) {
  const results =  await GET('/v3/userVariables', {
    params: { query: { variableId: variableId, includeCharts } },
  });
  return results.data[0];
}

// Fetch all the userVariable for the selected user
export async function getUserVariables(
  userId: string
): Promise<UserVariables[]> {
  const response =  await fetch(process.env.NEXT_PUBLIC_APP_URL + '/api/userVariables', {
    method: 'GET',
    headers: {
      'Content-Type': 'application/json',
    },
  });
  const userVariables = await response.json();
  return userVariables;
}

// Verify if the user has access to the userVariable
export async function verifyUserVariable(userVariableId: string) {
  const session = await getServerSession(authOptions)
  const count = await db.userVariable.count({
    where: {
      id: userVariableId,
      userId: session?.user.id,
    },
  })

  return count > 0
}
