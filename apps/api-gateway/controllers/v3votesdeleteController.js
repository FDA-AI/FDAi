const service = require('../services/v3votesdeleteService.js');

module.exports.deleteVote = function deleteVote(req, res) {
    service.deleteVote(req, res);
}

