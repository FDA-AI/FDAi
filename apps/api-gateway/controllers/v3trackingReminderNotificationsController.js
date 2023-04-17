const service = require('../services/v3trackingReminderNotificationsService.js');

module.exports.getTrackingReminderNotifications = function getTrackingReminderNotifications(req, res) {
    service.getTrackingReminderNotifications(req, res);
}

module.exports.postTrackingReminderNotifications = function postTrackingReminderNotifications(req, res) {
    service.postTrackingReminderNotifications(req, res);
}

