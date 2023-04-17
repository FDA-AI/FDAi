const service = require('../services/v3integration.jsService.js');

module.exports.getIntegrationJs = function getIntegrationJs(req, res) {
    service.getIntegrationJs(req, res);
}

