const service = require('../services/v3userVariablesdeleteService.js');

module.exports.deleteUserVariable = function deleteUserVariable(req, res) {
    service.deleteUserVariable(req, res);
}

