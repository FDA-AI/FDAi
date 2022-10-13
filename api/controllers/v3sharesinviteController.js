const service = require('../services/v3sharesinviteService.js');

module.exports.inviteShare = function inviteShare(req, res) {
    service.inviteShare(req, res);
}

