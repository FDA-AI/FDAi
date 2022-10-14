"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var react_1 = require("react");
var ide_toolbox_1 = require("@react-buddy/ide-toolbox");
var palette_1 = require("./palette");
var ComponentPreviews = function () {
    return <ide_toolbox_1.Previews palette={<palette_1.PaletteTree />}></ide_toolbox_1.Previews>;
};
exports.default = ComponentPreviews;
