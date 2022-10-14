"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.PaletteTree = void 0;
var react_1 = require("react");
var ide_toolbox_1 = require("@react-buddy/ide-toolbox");
var PaletteTree = function () { return (<ide_toolbox_1.Palette>
    <ide_toolbox_1.Category name="HTML">
      <ide_toolbox_1.Component name="a">
        <ide_toolbox_1.Variant requiredParams={['href']}>
          <a>Link</a>
        </ide_toolbox_1.Variant>
      </ide_toolbox_1.Component>
      <ide_toolbox_1.Component name="button">
        <ide_toolbox_1.Variant>
          <button>Button</button>
        </ide_toolbox_1.Variant>
      </ide_toolbox_1.Component>
    </ide_toolbox_1.Category>
  </ide_toolbox_1.Palette>); };
exports.PaletteTree = PaletteTree;
