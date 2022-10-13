const service = require('../services/v3variableCategoriesService.js');

module.exports.getVariableCategories = function getVariableCategories(req, res) {
    service.getVariableCategories(req, res);
}

