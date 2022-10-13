const service = require('../services/v3trackingRemindersdeleteService.js');

module.exports.deleteTrackingReminder = function deleteTrackingReminder(req, res) {
    service.deleteTrackingReminder(req, res);
}

