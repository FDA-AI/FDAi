const service = require('../services/v3votesService.js');

module.exports.postVote = function postVote(req, res) {
    service.postVote(req, res);
}

