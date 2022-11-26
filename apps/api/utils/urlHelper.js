const {numberFormat} = require("underscore.string");
var serverPort = 5000;
if(process.env.PORT){
  serverPort = numberFormat(process.env.PORT);
}
module.exports = {
  serverPort,
  websiteDomain: process.env.REACT_APP_WEBSITE_URL || `http://localhost:${serverPort}`,
  API_ORIGIN: process.env.API_ORIGIN || 'https://app.quantimo.do',
  loginSuccessRedirect: process.env.POST_LOGIN_PATH || "/#/app/onboarding",
  loginFailureRedirect: "/#/app/login",
  loginPath: "/#/app/login"
}
