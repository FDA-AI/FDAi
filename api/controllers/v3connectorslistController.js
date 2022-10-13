const service = require('../services/v3connectorslistService.js');

module.exports.getConnectors = function getConnectors(req, res) {
    service.getConnectors(req, res);
}

