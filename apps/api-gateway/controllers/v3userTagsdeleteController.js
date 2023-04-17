const service = require('../services/v3userTagsdeleteService.js');

module.exports.deleteUserTag = function deleteUserTag(req, res) {
    service.deleteUserTag(req, res);
}

