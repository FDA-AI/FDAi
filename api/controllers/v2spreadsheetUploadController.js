const service = require('../services/v2spreadsheetUploadService.js');

module.exports.measurementSpreadsheetUpload = function measurementSpreadsheetUpload(req, res) {
    service.measurementSpreadsheetUpload(req, res);
}

