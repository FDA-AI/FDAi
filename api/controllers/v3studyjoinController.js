const service = require('../services/v3studyjoinService.js');

module.exports.joinStudy = function joinStudy(req, res) {
    service.joinStudy(req, res);
}

