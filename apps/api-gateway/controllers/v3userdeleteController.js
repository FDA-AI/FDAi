const service = require('../services/v3userdeleteService.js');

module.exports.deleteUser = function deleteUser(req, res) {
    service.deleteUser(req, res);
}

