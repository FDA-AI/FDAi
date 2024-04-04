module.exports = {
  verbose: true,
  testEnvironment: 'node',
  moduleFileExtensions: ['js', 'json'],
  rootDir: './',
  testMatch: ['**/tests/**/*.js'],
  transform: {
    '^.+\\.js$': 'babel-jest',
  },
  collectCoverage: true,
  collectCoverageFrom: ['**/services/*.js'],
  coverageDirectory: '<rootDir>/coverage',
  coverageReporters: ['text', 'lcov'],
};
