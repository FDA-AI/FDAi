const service = require('../services/v3connectorsconnectorNameupdateService.js');

module.exports.updateConnector = function updateConnector(req, res) {
    service.updateConnector(req, res);
}

