const service = require('../services/v3unitsService.js');

module.exports.getUnits = function getUnits(req, res) {
    service.getUnits(req, res);
}

