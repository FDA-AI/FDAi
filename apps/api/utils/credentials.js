const urlHelper = require("./urlHelper");
const qm = require("../../ionic/src/js/qmHelpers");
const dataSources = require("../data/data-sources");
let credentials = {
  googleplus: {
    // We use this for mobile apps
    clientId: process.env.CONNECTOR_GOOGLE_CLIENT_ID || "REDACTED_GOOGLE_CLIENT_SECRET",
    clientSecret: process.env.CONNECTOR_GOOGLE_CLIENT_SECRET ||
                  "REDACTED_GOOGLE_CLIENT_ID",
    scopes: ["email", "profile"]
  },
  quantimodo: {
    // We use this for mobile apps
    clientId: process.env.CONNECTOR_QUANTIMODO_CLIENT_ID || "oauth_test_client",
    clientSecret: process.env.CONNECTOR_QUANTIMODO_CLIENT_SECRET || "REDACTED_QUANTIMODO_CLIENT_SECRET"
  },
  github: {
    // We use this for mobile apps
    clientId: process.env.CONNECTOR_GITHUB_CLIENT_ID || "REDACTED_GITHUB_CLIENT_SECRET",
    clientSecret: process.env.CONNECTOR_GITHUB_CLIENT_SECRET || "REDACTED_GITHUB_CLIENT_ID",
    scopes: ["user:email", "read:user", "repo"]
  },
  facebook: {
    // We use this for mobile apps
    clientId: process.env.CONNECTOR_FACEBOOK_CLIENT_ID,
    clientSecret: process.env.CONNECTOR_FACEBOOK_CLIENT_SECRET
  },
  twitter: {
    // We use this for mobile apps
    clientId: process.env.CONNECTOR_TWITTER_CLIENT_ID || "REDACTED_GITHUB_CLIENT_SECRET",
    clientSecret: process.env.CONNECTOR_TWITTER_CLIENT_SECRET || "REDACTED_GITHUB_CLIENT_ID"
  },
  discord: {
    clientId: process.env.CONNECTOR_DISCORD_CLIENT_ID || "REDACTED_DISCORD_CLIENT_ID",
    clientSecret: process.env.CONNECTOR_DISCORD_CLIENT_SECRET || "REDACTED_DISCORD_CLIENT_SECRET"
  },
  getScopes(connectorName){
    let scopes = this[connectorName].scopes;
    return scopes;
  }
};
credentials.find = function(strategyName, connectorName){
  let res = {
    clientID: credentials[connectorName].clientId,
    clientSecret: credentials[connectorName].clientSecret,
    callbackURL: `${urlHelper.websiteDomain}/auth/${strategyName}/callback`,
    passReqToCallback: true
  };
  if(connectorName === "twitter"){
    res.consumerKey = credentials[connectorName].clientId;
    res.consumerSecret = credentials[connectorName].clientSecret;
    delete res.clientID;
    delete res.clientSecret;
  }
  return res;
};
module.exports = credentials;
