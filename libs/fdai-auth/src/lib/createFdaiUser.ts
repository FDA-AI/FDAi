import fetch from 'node-fetch';

// Environment variables for configuration
const FDAI_API_ORIGIN = process.env['FDAI_API_ORIGIN'] || 'https://safe.fdai.earth';
const FDAI_CLIENT_ID = process.env['FDAI_CLIENT_ID'] || 'oauth_test_client';
const FDAI_CLIENT_SECRET = process.env['FDAI_CLIENT_SECRET'] || 'oauth_test_secret';

/**
 * Creates an FDAi user and returns the user ID.
 * @param {string} clientUserId - The unique identifier for the user in the client's system.
 * @returns {Promise<string>} The FDAi user ID.
 */
export async function createFdaiUser(clientUserId: string): Promise<string> {
    const url = `${FDAI_API_ORIGIN}/api/v1/user`;
    const data = {
        clientUserId,
        clientId: FDAI_CLIENT_ID,
        clientSecret: FDAI_CLIENT_SECRET,
    };

    try {
        const response = await fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data),
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
