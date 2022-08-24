import {defineConfig} from "cypress";

const {env} = process;
let apiHost = env.API_HOST || "app.quantimo.do";
let oAuthAppHost = env.OAUTH_APP_HOST || "http://localhost:5000";
let baseUrl = env.BASE_URL || oAuthAppHost;
let builderHost = env.BUILDER_HOST || oAuthAppHost
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
