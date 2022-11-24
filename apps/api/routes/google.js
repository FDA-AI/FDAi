const passport = require("passport");
const express = require("express");
const { Strategy: GoogleStrategy } = require("passport-google-oauth2");
const urlHelper = require("../utils/urlHelper");
const db = require("../db");
const credentials = require("../utils/credentials");
var router = express.Router();


//Use "GoogleStrategy" as the Authentication Strategy
passport.use(new GoogleStrategy({
  clientID:     credentials.GOOGLE_CLIENT_ID,
  clientSecret: credentials.GOOGLE_CLIENT_SECRET,
  callbackURL: `${urlHelper.websiteDomain}/auth/google/callback`,
  passReqToCallback   : true
}, function(request, accessToken, refreshToken, profile, done) {
  console.log("authUser", profile)
  return db.findByEmail(profile.email).then((user) => {
    if(user){
      return db.createAccessToken(user, request).then((token) => {
        user.access_token = token;
        return done(null, user);
      })
    }
    return db.createUser(profile).then((user) => {
      return db.createAccessToken(user, request).then((token) => {
        user.access_token = token;
        return done(null, user);
      })
    })
  })
}));
router.get('/auth/google',
  passport.authenticate('google', { scope:
      [ 'email', 'profile' ] }
  ));
router.get('/auth/google/callback',
  passport.authenticate( 'google', {
    //successRedirect: '/dashboard',
    failureRedirect: '/login'
  }), (req, res) => {
    //debugger
    res.redirect(urlHelper.POST_LOGIN_PATH);
  });

module.exports = router;
