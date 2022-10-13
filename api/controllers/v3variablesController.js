const service = require('../services/v3variablesService.js');

module.exports.getVariables = function getVariables(req, res) {
    service.getVariables(req, res);
}

module.exports.postUserVariables = function postUserVariables(req, res) {
    service.postUserVariables(req, res);
}

