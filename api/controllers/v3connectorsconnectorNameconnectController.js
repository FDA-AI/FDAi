const service = require('../services/v3connectorsconnectorNameconnectService.js');

module.exports.connectConnector = function connectConnector(req, res) {
    service.connectConnector(req, res);
}

