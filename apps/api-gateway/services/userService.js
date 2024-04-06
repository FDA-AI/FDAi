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
      'X-Client-Id': process.env.FDAI_CLIENT_ID, // Get at https://builder.fdai.earth/app/public/#/app/configuration
      'X-Client-Secret': process.env.FDAI_CLIENT_SECRET,  // Get at https://builder.fdai.earth/app/public/#/app/configuration
    },
    body: JSON.stringify({
      clientUserId: yourSystemUserId
    }),
  });
  const responseData = await response.json();
  return responseData.user;
}

module.exports.createFdaiUser = getOrCreateFdaiUser;
