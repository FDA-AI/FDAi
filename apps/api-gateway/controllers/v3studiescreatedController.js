const service = require('../services/v3studiescreatedService.js');

module.exports.getStudiesCreated = function getStudiesCreated(req, res) {
    service.getStudiesCreated(req, res);
}

