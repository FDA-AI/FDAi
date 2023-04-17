const service = require('../services/v3studypublishService.js');

module.exports.publishStudy = function publishStudy(req, res) {
    service.publishStudy(req, res);
}

