const service = require('../services/v3usersService.js');

module.exports.getUsers = function getUsers(req, res) {
    service.getUsers(req, res);
}

