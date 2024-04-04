const fetch = require('node-fetch');
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient()
let randomUserIdForTest = Math.floor(Math.random() * Math.pow(2, 31));
let yourUserId = randomUserIdForTest;
async function getYourUser(yourUserId) {
  let user = await prisma.users.findUnique({
    where: {
      id: yourUserId
    }
  })
  if(user) {
    return user;
  }
  return prisma.users.create({
    data: {
      id: yourUserId
    }
  });
}

// Function to get or create a user
async function getOrCreateFdaiUser(yourUserId) {
  let your_user = await getYourUser(yourUserId)
  if(your_user && your_user.fdai_user_id) {
    return your_user;
  }

  let response = await fetch(`https://safe.fdai.earth/api/v1/user`, {
    method: 'POST',
    headers: {
      'Content-type': 'application/json',
      'X-Client-ID': process.env.FDAI_CLIENT_ID,
      'X-Client-Secret': process.env.FDAI_CLIENT_SECRET
    },
    body: JSON.stringify({
      clientUserId: yourUserId
    })
  });
  response = await response.json();
  const fdaiUser = response.user;
  // Update your user with the fdai_user_id
  await prisma.users.update({
    where: { id: yourUserId },
    data: {
      fdai_user_id: fdaiUser.id,
      fdai_scope: fdaiUser.scope,
      fdai_access_token: fdaiUser.accessToken,
      fdai_refresh_token: fdaiUser.refreshToken,
      fdai_access_token_expires_at: new Date(fdaiUser.accessTokenExpires).toISOString()
    }
  });
  return response.user
}

async function postMeasurements(fdaiUser, measurements) {
  const response = await fetch(`https://safe.fdai.earth/api/v1/measurements`, {
    method: 'POST',
    headers: {
      'Content-type': 'application/json',
      'X-Client-ID': process.env.FDAI_CLIENT_ID,
      'X-Client-Secret': process.env.FDAI_CLIENT_SECRET,
      'Authorization': `Bearer ${fdaiUser.accessToken}`
    },
    body: JSON.stringify({
      measurements
    })
  });
  console.log('response', response.status);
  console.log('response', response.statusText);
  console.log('response', response.headers);
  console.log('response', response.body);
}

async function test() {
  let yourUser = await getYourUser(yourUserId);
  // get or create FDAi User ID and save the
  const fdaiUser = await getOrCreateFdaiUser(yourUser.id);
  yourUser = await getYourUser(yourUserId); // get the updated user
  // save measurements
  const measurements = [ getBupropionMeasurement(new Date().toISOString())];
  await postMeasurements(fdaiUser, measurements);

}

test().catch(e => {
  console.error(e);
  process.exit(1);
}).finally(async () => {
  await prisma.$disconnect();
  process.exit(0);
});


function getBupropionMeasurement(startAt){
  return {
    "combinationOperation": "SUM",
    startAt,
    "unitAbbreviatedName": "mg",
    "value": 150,
    "variableCategoryName": "Treatments",
    "variableName": "Bupropion Sr",
    "note": "",
  }
}
