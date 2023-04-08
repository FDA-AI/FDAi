const service = require('../services/v3measurementsupdateService.js');

module.exports.updateMeasurement = function updateMeasurement(req, res) {
    service.updateMeasurement(req, res);
}

