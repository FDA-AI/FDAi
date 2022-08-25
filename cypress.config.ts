import {defineConfig} from "cypress";

const {env} = process;
let apiOrigin = env.API_ORIGIN || "app.quantimo.do";
let appOrigin = env.OAUTH_APP_ORIGIN || "http://localhost:5000";
let baseUrl = env.BASE_URL || appOrigin;
let builderOrigin = env.BUILDER_ORIGIN || appOrigin
export default defineConfig({
  e2e: {
    setupNodeEvents(on, config) {
      // implement node event listeners here
      //const conf = JSON.parse(JSON.stringify(config));
      console.log("setupNodeEvents", on, config);
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
      "API_ORIGIN": apiOrigin,
      "OAUTH_APP_ORIGIN": appOrigin,
      "BUILDER_ORIGIN": builderOrigin,
      "abort_strategy": true
    },
    "reporter": "cypress-multi-reporters",
    "reporterOptions": {
      "configFile": "cypress/reporterOpts.json"
    },
    "screenshotsFolder": "cypress/reports/assets"
  },
});
