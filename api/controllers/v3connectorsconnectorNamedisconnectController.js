const service = require('../services/v3connectorsconnectorNamedisconnectService.js');

module.exports.disconnectConnector = function disconnectConnector(req, res) {
    service.disconnectConnector(req, res);
}

