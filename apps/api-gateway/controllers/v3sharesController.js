const service = require('../services/v3sharesService.js');

module.exports.getShares = function getShares(req, res) {
    service.getShares(req, res);
}

