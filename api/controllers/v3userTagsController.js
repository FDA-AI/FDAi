const service = require('../services/v3userTagsService.js');

module.exports.postUserTags = function postUserTags(req, res) {
    service.postUserTags(req, res);
}

