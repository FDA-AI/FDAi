const service = require('../services/v3measurementsdeleteService.js');

module.exports.deleteMeasurement = function deleteMeasurement(req, res) {
    service.deleteMeasurement(req, res);
}

