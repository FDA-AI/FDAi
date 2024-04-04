const {numberFormat} = require("underscore.string");
//envHelper.loadEnvFromDopplerOrDotEnv(null);
var port = process.env.EXPRESS_PORT;
let fallbackServerUrl = `http://localhost:${port}`;
let envs = process.env
let apiOrigin = process.env.QM_API_ORIGIN
if(!apiOrigin){
  apiOrigin = 'https://app.quantimo.do';
}
module.exports = {
  serverPort: port,
  serverOrigin: process.env[process.env.EXPRESS_ORIGIN] || fallbackServerUrl,
  QM_API_ORIGIN: apiOrigin,
  loginSuccessRedirect: process.env[process.env.LOGIN_SUCCESS_REDIRECT] || "/#/app/onboarding",
  loginFailureRedirect: "/#/app/login",
  loginPath: "/#/app/login"
}
