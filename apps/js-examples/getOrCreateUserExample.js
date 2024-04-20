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
async function getOrCreateDfdaUser(yourUserId) {
  let your_user = await getYourUser(yourUserId)
  if(your_user && your_user.fdai_user_id) {
    return your_user;
  }

  let response = await fetch(`https://safe.dfda.earth/api/v1/user`, {
    method: 'POST',
    headers: {
      'Content-type': 'application/json',
      'X-Client-ID': process.env.DFDA_CLIENT_ID,
      'X-Client-Secret': process.env.DFDA_CLIENT_SECRET
    },
    body: JSON.stringify({
      clientUserId: yourUserId
    })
  });
  response = await response.json();
  const dfdaUser = response.user;
  // Update your user with the fdai_user_id
  await prisma.users.update({
    where: { id: yourUserId },
    data: {
      fdai_user_id: dfdaUser.id,
      fdai_scope: dfdaUser.scope,
      fdai_access_token: dfdaUser.accessToken,
      fdai_refresh_token: dfdaUser.refreshToken,
      fdai_access_token_expires_at: new Date(dfdaUser.accessTokenExpires).toISOString()
    }
  });
  return response.user
}

async function postMeasurements(dfdaUser, measurements) {
  const response = await fetch(`https://safe.dfda.earth/api/v1/measurements`, {
    method: 'POST',
    headers: {
      'Content-type': 'application/json',
      'X-Client-ID': process.env.DFDA_CLIENT_ID,
      'X-Client-Secret': process.env.DFDA_CLIENT_SECRET,
      'Authorization': `Bearer ${dfdaUser.accessToken}`
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
  const dfdaUser = await getOrCreateDfdaUser(yourUser.id);
  yourUser = await getYourUser(yourUserId); // get the updated user
  // save measurements
  const measurements = [ getBupropionMeasurement(new Date().toISOString())];
  await postMeasurements(dfdaUser, measurements);

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
