import { defineConfig } from 'cypress'

export default defineConfig({
  e2e: {
    // We've imported your old cypress plugins here.
    // You may want to clean this up later by importing these.
    setupNodeEvents(on, config) {
      return require('../plugins/index.js')(on, config)
    },
    baseUrl: 'http://localhost:80',
    specPattern: 'cypress/e2e/**/*.{js,jsx,ts,tsx}',
    chromeWebSecurity: false,
    projectId: 'ee8wan',
    pageLoadTimeout: 60000,
    videoCompression: false,
    videoUploadOnPasses: false,
    video: false,
    env: {
      API_HOST: 'localhost',
      OAUTH_APP_HOST: 'dev-web.quantimo.do',
      BUILDER_HOST: 'dev-builder.quantimo.do',
      abort_strategy: true,
    },
    reporter: 'cypress-multi-reporters',
    reporterOptions: {
      configFile: 'cypress/reporterOpts.json',
    },
    screenshotsFolder: 'cypress/reports/mocha/assets',
  },
})
