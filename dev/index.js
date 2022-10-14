"use strict";
// noinspection JSUnusedGlobalSymbols
Object.defineProperty(exports, "__esModule", { value: true });
exports.useInitial = exports.ComponentPreviews = void 0;
var react_1 = require("react");
var useInitial_1 = require("./useInitial");
Object.defineProperty(exports, "useInitial", { enumerable: true, get: function () { return useInitial_1.useInitial; } });
var ComponentPreviews = react_1.default.lazy(function () { return Promise.resolve().then(function () { return require('./previews'); }); });
exports.ComponentPreviews = ComponentPreviews;
