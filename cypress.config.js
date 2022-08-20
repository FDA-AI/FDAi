"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var cypress_1 = require("cypress");
exports.default = cypress_1.defineConfig({
    e2e: {
        setupNodeEvents: function (on, config) {
            // implement node event listeners here
        },
    },
});
