const service = require('../services/v3userService.js');

module.exports.getUser = function getUser(req, res) {
    service.getUser(req, res);
}

