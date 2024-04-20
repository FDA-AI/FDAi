const userService = require('../services/userService');

describe('createDfdaUser function in userService.js', () => {
  it('should successfully create a user and return a user ID', async () => {
    // Mock the API call to simulate a successful user creation
    const mockUserId = '12345';
    const expectedDfdaUserId = 'fdai-67890';
    jest.spyOn(global, 'fetch').mockImplementation(() =>
      Promise.resolve({
        json: () => Promise.resolve({ userId: expectedDfdaUserId }),
      })
    );

    const dfdaUserId = await userService.createDfdaUser(mockUserId);
    expect(dfdaUserId).toEqual(expectedDfdaUserId);

    // Restore the original implementation
    global.fetch.mockRestore();
  });

  it('should throw an error when the API call fails', async () => {
    // Mock the API call to simulate a failure
    jest.spyOn(global, 'fetch').mockImplementation(() =>
      Promise.reject(new Error('API call failed'))
    );

    await expect(userService.createDfdaUser('12345')).rejects.toThrow('API call failed');

    // Restore the original implementation
    global.fetch.mockRestore();
  });
});
