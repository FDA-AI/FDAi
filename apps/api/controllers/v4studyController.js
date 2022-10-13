const service = require('../services/v4studyService.js');

module.exports.getStudy = function getStudy(req, res) {
    service.getStudy(req, res);
}

