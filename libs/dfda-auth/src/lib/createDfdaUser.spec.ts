import { createDfdaUser } from './createDfdaUser';

describe('createDfdaUser', () => {
  it('should create a user and return the user ID', async () => {
    // Mock environment variables
    process.env['DFDA_API_ORIGIN'] = 'https://safe.dfda.earth';
    process.env['DFDA_CLIENT_ID'] = 'test_client_id';
    process.env['DFDA_CLIENT_SECRET'] = 'test_client_secret';

    // Mock clientUserId
    const clientUserId = 'testUser123';

    // Call the createDfdaUser function
    const userId = await createDfdaUser(clientUserId);

    // Assertions
    expect(userId).toBeDefined();
    expect(typeof userId).toBe('string');
  });
});
