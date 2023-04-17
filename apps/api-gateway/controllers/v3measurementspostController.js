const service = require('../services/v3measurementspostService.js');

module.exports.postMeasurements = function postMeasurements(req, res) {
    service.postMeasurements(req, res);
}

