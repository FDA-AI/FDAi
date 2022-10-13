const service = require('../services/v3oauth2tokenService.js');

module.exports.getAccessToken = function getAccessToken(req, res) {
    service.getAccessToken(req, res);
}

