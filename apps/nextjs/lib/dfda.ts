import { db } from "@/lib/db"
import { UserVariable } from "@/types/models/UserVariable";

async function getYourUser(yourUserId: any) {
  let user = await db.user.findUnique({
    where: {
      id: yourUserId
    }
  })
  if(user) {
    return user;
  }
  return db.user.create({
    data: {
      id: yourUserId
    }
  });
}

// Function to get or create a user
export async function getOrCreateDfdaUser(yourUserId: any) {
  let your_user = await getYourUser(yourUserId)
  if (your_user && your_user.dfda_user_id) {
    return your_user;
  }

  let response = await fetch(`https://safe.dfda.earth/api/v1/user`, {
    method: 'POST',
    headers: {
      'Content-type': 'application/json',
      'X-Client-ID': process.env.DFDA_CLIENT_ID!,
      'X-Client-Secret': process.env.DFDA_CLIENT_SECRET!
    },
    body: JSON.stringify({
      clientUserId: yourUserId
    })
  });
  let jsonResponse = await response.json();
  const dfdaUser = jsonResponse.user;
  // Update your user with the dfda_user_id
  await db.user.update({
    where: { id: yourUserId },
    data: {
      dfda_user_id: dfdaUser.id,
      dfda_scope: dfdaUser.scope,
      dfda_access_token: dfdaUser.accessToken,
      dfda_refresh_token: dfdaUser.refreshToken,
      dfda_access_token_expires_at: new Date(dfdaUser.accessTokenExpires).toISOString()
    }
  });
  return jsonResponse.user;
}

export async function getOrCreateDfdaAccessToken(yourUserId: any) {
  let your_user = await getYourUser(yourUserId)
  if (your_user && your_user.dfda_access_token) {
    return your_user.dfda_access_token;
  }

  const user = await getOrCreateDfdaUser(yourUserId);
  return user.accessToken;
}

export async function getUserVariable(variableId: number, params?: any): Promise<UserVariable> {
  let path = `/api/dfda/userVariables?variableId=${variableId}`;
  if (params) {path += `?${new URLSearchParams(params).toString()}`}
  let response = await fetch(path);
  let jsonResponse = await response.json();
  return jsonResponse[0];
}

export async function getUserVariableWithCharts(variableId: number): Promise<UserVariable> {
  return await getUserVariable(variableId, {includeCharts: true})
}
