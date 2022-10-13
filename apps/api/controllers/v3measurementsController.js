const service = require('../services/v3measurementsService.js');

module.exports.getMeasurements = function getMeasurements(req, res) {
    service.getMeasurements(req, res);
}

