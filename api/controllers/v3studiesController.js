const service = require('../services/v3studiesService.js');

module.exports.getStudies = function getStudies(req, res) {
    service.getStudies(req, res);
}

