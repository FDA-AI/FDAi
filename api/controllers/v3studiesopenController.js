const service = require('../services/v3studiesopenService.js');

module.exports.getOpenStudies = function getOpenStudies(req, res) {
    service.getOpenStudies(req, res);
}

