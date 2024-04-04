const envHelper = require("../utils/envHelper.js");

export async function getUser(req, res) {
    res.send({
        message: 'This is the mockup controller for getUser'
    });
}

module.exports.getUser = getUser;

/**
 * Creates an FDAi user and returns the user ID.
 * @param {string} yourSystemUserId - The unique identifier for the user in the client's system.
 * @returns {Promise<string>} The FDAi user ID.
 */
export async function getOrCreateFdaiUser(yourSystemUserId) {
  const response = await fetch(`https://safe.fdai.earth/api/v1/user`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-Client-Id': envHelper.getRequiredEnv('FDAI_CLIENT_ID'),
      'X-Client-Secret': envHelper.getRequiredEnv('FDAI_CLIENT_SECRET'),
    },
    body: JSON.stringify({
      clientUserId: yourSystemUserId
    }),
  });
  const responseData = await response.json();
  return responseData.user;
}

module.exports.createFdaiUser = getOrCreateFdaiUser;
