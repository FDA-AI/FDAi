const service = require('../services/v3feedService.js');

module.exports.getFeed = function getFeed(req, res) {
    service.getFeed(req, res);
}

module.exports.postFeed = function postFeed(req, res) {
    service.postFeed(req, res);
}

