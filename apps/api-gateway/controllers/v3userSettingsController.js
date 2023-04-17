const service = require('../services/v3userSettingsService.js');

module.exports.postUserSettings = function postUserSettings(req, res) {
    service.postUserSettings(req, res);
}

