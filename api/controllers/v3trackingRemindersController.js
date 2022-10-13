const service = require('../services/v3trackingRemindersService.js');

module.exports.getTrackingReminders = function getTrackingReminders(req, res) {
    service.getTrackingReminders(req, res);
}

module.exports.postTrackingReminders = function postTrackingReminders(req, res) {
    service.postTrackingReminders(req, res);
}

