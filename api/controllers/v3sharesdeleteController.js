const service = require('../services/v3sharesdeleteService.js');

module.exports.deleteShare = function deleteShare(req, res) {
    service.deleteShare(req, res);
}

