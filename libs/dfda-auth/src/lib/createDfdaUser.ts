import fetch from 'node-fetch';

/**
 * Creates an FDAi user and returns the user ID.
 * @param {string} yourSystemUserId - The unique identifier for the user in the client's system.
 * @returns {Promise<string>} The FDAi user ID.
 */
export async function createDfdaUser(yourSystemUserId: string): Promise<string> {
    try {
        const response = await fetch(`https://safe.dfda.earth/api/v1/user`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-Client-Id': process.env['DFDA_CLIENT_ID'] || 'oauth_test_client',
                'X-Client-Secret': process.env['DFDA_CLIENT_SECRET'] || 'oauth_test_secret',
            },
            body: JSON.stringify({
              clientUserId: yourSystemUserId
            }),
        });

        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }

        const responseData = await response.json();
        return responseData.user.id;
    } catch (error) {
        console.error('Error creating FDAi user:', error);
        throw error;
    }
}
