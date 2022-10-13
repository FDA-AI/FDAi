import {defineConfig} from "cypress";
// @ts-ignore
import * as qmLog from "ts/qm.log";

const {env} = process;
let baseUrl = env.BASE_URL || "http://localhost:5000";
let apiOrigin = env.API_ORIGIN || "https://app.quantimo.do";
let appOrigin = env.OAUTH_APP_ORIGIN || baseUrl;
let builderOrigin = env.BUILDER_ORIGIN || appOrigin
export default defineConfig({
  e2e: {
    setupNodeEvents(on, config) {
      // implement node event listeners here
      //const conf = JSON.parse(JSON.stringify(config));
      qmLog.debug("setupNodeEvents Plugin Events", on);
      qmLog.info("setupNodeEvents Config:", config);
      qmLog.info("setupNodeEvents config.env:", config.env);
    },
    "chromeWebSecurity": false,
    "baseUrl": baseUrl,
    "projectId": env.CURRENTS_PROJECT_ID || env.CYPRESS_IO_PROJECT_ID,
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
