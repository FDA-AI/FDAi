"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var jest_1 = require("@nrwl/jest");
exports.default = {
    projects: (0, jest_1.getJestProjects)(),
    // testTimeout: 20000, Doesn't work here or in tests with jest.setTimeout(30000). Have to set in jest.preset.
};
