const service = require('../services/v3studycreateService.js');

module.exports.createStudy = function createStudy(req, res) {
    service.createStudy(req, res);
}

