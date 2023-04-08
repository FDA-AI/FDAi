const service = require('../services/v3connectmobileService.js');

module.exports.getMobileConnectPage = function getMobileConnectPage(req, res) {
    service.getMobileConnectPage(req, res);
}

