const service = require('../services/v3userVariablesresetService.js');

module.exports.resetUserVariableSettings = function resetUserVariableSettings(req, res) {
    service.resetUserVariableSettings(req, res);
}

