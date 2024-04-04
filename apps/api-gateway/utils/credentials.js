const urlHelper = require("./urlHelper");
const qm = require("../../dfda-1/public/app/public/js/qmHelpers");
const dataSources = require("../data/data-sources");
let credentials = {
  getScopes(connectorName){
    const dataSource = dataSources[connectorName] || null;
    if(dataSource){
      return dataSource.scopes;
    } else {
      throw Error("data/data-sources does not contain connector called: " + connectorName);
    }
  }
};
function getRequiredEnv(name){
  let val = this.getEnv(name);
  if(val === null || typeof val === "undefined"){
    throw Error("You must set the environment variable " + name);
  }
  return val
}
credentials.find = function(strategyName, connectorName){
  let toUpperCase = strategyName.toUpperCase();
  let clientID = getRequiredEnv("CONNECTOR_" + toUpperCase + "_CLIENT_ID");
  let clientSecret = getRequiredEnv("CONNECTOR_" + toUpperCase + "_CLIENT_SECRET");
  let res = {
    clientID: clientID,
    clientSecret: clientSecret,
    callbackURL: `${urlHelper.serverOrigin}/auth/${strategyName}/callback`,
    passReqToCallback: true
  };
  if(connectorName === "twitter"){
    res.consumerKey = clientID;
    res.consumerSecret = clientSecret;
    delete res.clientID;
    delete res.clientSecret;
  }
  return res;
};
module.exports = credentials;
