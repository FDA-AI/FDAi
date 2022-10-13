const service = require('../services/v3correlationsService.js');

module.exports.getCorrelations = function getCorrelations(req, res) {
    service.getCorrelations(req, res);
}

