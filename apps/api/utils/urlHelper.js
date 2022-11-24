const {numberFormat} = require("underscore.string");
var serverPort = 5000;
if(process.env.PORT){
  serverPort = numberFormat(process.env.PORT);
}

const websiteDomain = process.env.REACT_APP_WEBSITE_URL || `http://localhost:${serverPort}`;
const API_ORIGIN = process.env.API_ORIGIN || 'https://app.quantimo.do'
const POST_LOGIN_PATH = process.env.POST_LOGIN_PATH || "/#/app/onboarding"

module.exports = {
  websiteDomain,
  serverPort,
  API_ORIGIN,
  POST_LOGIN_PATH
}
