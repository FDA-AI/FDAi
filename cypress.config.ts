import {defineConfig} from "cypress";

const {env} = process;
let baseUrl = env.BASE_URL || "http://localhost:5000";
let apiHost = env.API_HOST || "app.quantimo.do";
let oAuthAppHost = env.OAUTH_APP_HOST || apiHost;
let builderHost = env.BUILDER_HOST || 'dev-builder.quantimo.do'
export default defineConfig({
  e2e: {
    setupNodeEvents(on, config) {
      // implement node event listeners here
    },
    "chromeWebSecurity": false,
    "baseUrl": baseUrl,
    "projectId": env.CYPRESS_PROJECT_ID || "1rj181",
    "pageLoadTimeout": 60000,
    "videoCompression": false,
    "videoUploadOnPasses": false,
    "experimentalSessionAndOrigin": false,
    "video": true,
    "env": {
      "API_HOST": apiHost,
      "OAUTH_APP_HOST": oAuthAppHost,
      "BUILDER_HOST": builderHost,
      "abort_strategy": true
    },
    "reporter": "cypress-multi-reporters",
    "reporterOptions": {
      "configFile": "cypress/reporterOpts.json"
    },
    "screenshotsFolder": "cypress/reports/assets"
  },
});
