const service = require('../services/v3studiesjoinedService.js');

module.exports.getStudiesJoined = function getStudiesJoined(req, res) {
    service.getStudiesJoined(req, res);
}

