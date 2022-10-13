const service = require('../services/v3unitCategoriesService.js');

module.exports.getUnitCategories = function getUnitCategories(req, res) {
    service.getUnitCategories(req, res);
}

