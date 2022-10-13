const service = require('../services/v3oauth2authorizeService.js');

module.exports.getOauthAuthorizationCode = function getOauthAuthorizationCode(req, res) {
    service.getOauthAuthorizationCode(req, res);
}

