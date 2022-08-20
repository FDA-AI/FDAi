"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var cypress_1 = require("cypress");
exports.default = cypress_1.defineConfig({
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
    e2e: {
        // We've imported your old cypress plugins here.
        // You may want to clean this up later by importing these.
        setupNodeEvents: function (on, config) {
            return require('./cypress/plugins/index.js')(on, config);
        },
        baseUrl: 'http://localhost:80',
        specPattern: 'cypress/e2e/**/*.{js,jsx,ts,tsx}',
    },
});
//# sourceMappingURL=cypress.development.config.js.map