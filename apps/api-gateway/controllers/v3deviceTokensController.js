const service = require('../services/v3deviceTokensService.js');

module.exports.postDeviceToken = function postDeviceToken(req, res) {
    service.postDeviceToken(req, res);
}

