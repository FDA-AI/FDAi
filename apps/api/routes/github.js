const passport = require("passport");
const express = require("express");
const { Strategy: Strategy } = require("passport-github");
const urlHelper = require("../utils/urlHelper");
const db = require("../db");
const credentials = require("../utils/credentials");
const authHelper = require("../utils/authHelper");
var router = express.Router();
const serviceName = "github";
passport.use(new Strategy(credentials.find(serviceName),
  function(request, accessToken, refreshToken, profile, done) {
    return authHelper.handleSocialLogin(profile, request, done);
  }));
router.get('/auth/' + serviceName,
  passport.authenticate(serviceName, {
    scope: credentials.getScopes(serviceName),
  }));
router.get('/auth/' + serviceName + '/callback',
  passport.authenticate( serviceName, {
    //successRedirect: urlHelper.loginFailureRedirect,
    failureRedirect: urlHelper.loginFailureRedirect
  }), (req, res) => {
    //debugger
    res.redirect(urlHelper.loginSuccessRedirect);
  });

module.exports = router;
