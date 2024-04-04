const userService = require('../services/userService');

describe('createFdaiUser function in userService.js', () => {
  it('should successfully create a user and return a user ID', async () => {
    // Mock the API call to simulate a successful user creation
    const mockUserId = '12345';
    const expectedFdaiUserId = 'fdai-67890';
    jest.spyOn(global, 'fetch').mockImplementation(() =>
      Promise.resolve({
        json: () => Promise.resolve({ userId: expectedFdaiUserId }),
      })
    );

    const fdaiUserId = await userService.createFdaiUser(mockUserId);
    expect(fdaiUserId).toEqual(expectedFdaiUserId);

    // Restore the original implementation
    global.fetch.mockRestore();
  });

  it('should throw an error when the API call fails', async () => {
    // Mock the API call to simulate a failure
    jest.spyOn(global, 'fetch').mockImplementation(() =>
      Promise.reject(new Error('API call failed'))
    );

    await expect(userService.createFdaiUser('12345')).rejects.toThrow('API call failed');

    // Restore the original implementation
    global.fetch.mockRestore();
  });
});
