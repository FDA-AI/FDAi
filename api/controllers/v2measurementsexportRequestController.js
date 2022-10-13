const service = require('../services/v2measurementsexportRequestService.js');

module.exports.measurementExportRequest = function measurementExportRequest(req, res) {
    service.measurementExportRequest(req, res);
}

