const Str = require("@supercharge/strings");
/**
 * Translate all top-level keys of the given `object` to camelCase.
 *
 * @param {Object} object
 *
 * @returns {Object}
 */
function camelCaseKeys (object) {
  return Object
    .entries(object)
    .reduce((carry, [key, value]) => {
      carry[Str(key).camel().get()] = value

      return carry
    }, {})
}
/**
 * Replace all occurrences of `find` in `str` with `replace`.
 *
 * @param {String} str
 * @param {String} find
 * @param {String} replace
 *
 * @returns {String}
 */
function replaceAll(str, find, replace){
  function escapeRegExp(str){
    return str.replace(/([.*+?^=!:${}()|\[\]\/\\])/g, "\\$1");
  }
  return str.replace(new RegExp(escapeRegExp(find), 'g'), replace);
}

module.exports = {
  camelCaseKeys,
  replaceAll
}
