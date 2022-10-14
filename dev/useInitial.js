"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.useInitial = void 0;
var react_1 = require("react");
var useInitial = function () {
    var _a = (0, react_1.useState)({
        loading: false,
        error: false,
    }), status = _a[0], setStatus = _a[1];
    /*
      Implement hook functionality here.
      If you need to execute async operation, set loading to true and when it's over, set loading to false.
      If you caught some errors, set error status to true.
      Initial hook is considered to be successfully completed if it will return {loading: false, error: false}.
    */
    return status;
};
exports.useInitial = useInitial;
