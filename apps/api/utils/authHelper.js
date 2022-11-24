const db = require("../db");
function handleSocialLogin(profile, request, done){
  console.log("profile", profile)
  let email = profile.email;
  if(!email && profile.emails && profile.emails[0] && profile.emails[0].value){
    email = profile.emails[0].value;
  }
  if(!email && profile.emails && profile.emails[0] && profile.emails[0]){
    email = profile.emails[0];
  }
  if(!email){
    throw Error("No email found in profile", profile);
  }
  return db.findByEmail(email).then((user) => {
    if(user){
      return db.createAccessToken(user, request).then((token) => {
        user.access_token = token;
        return done(null, user);
      });
    }
    return db.createUser(profile).then((user) => {
      return db.createAccessToken(user, request).then((token) => {
        user.access_token = token;
        return done(null, user);
      });
    });
  });
}

module.exports = {
  handleSocialLogin
}
