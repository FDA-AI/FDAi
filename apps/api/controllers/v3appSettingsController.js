const service = require('../services/v3appSettingsService.js');

module.exports.getAppSettings = function getAppSettings(req, res) {
    service.getAppSettings(req, res);
}

