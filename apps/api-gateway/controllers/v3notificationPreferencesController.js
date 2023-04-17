const service = require('../services/v3notificationPreferencesService.js');

module.exports.getNotificationPreferences = function getNotificationPreferences(req, res) {
    service.getNotificationPreferences(req, res);
}

