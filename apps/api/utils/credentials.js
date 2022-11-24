const urlHelper = require("./urlHelper");
let credentials = {
    google: {
        // We use this for mobile apps
        clientId: process.env.CONNECTOR_GOOGLE_CLIENT_ID || "REDACTED_GOOGLE_CLIENT_SECRET",
        clientSecret: process.env.CONNECTOR_GOOGLE_CLIENT_SECRET || "REDACTED_GOOGLE_CLIENT_ID",
        scopes: ['email', 'profile']
    },
    quantimodo: {
        // We use this for mobile apps
        clientId: process.env.CONNECTOR_QUANTIMODO_CLIENT_ID || 'oauth_test_client',
        clientSecret: process.env.CONNECTOR_QUANTIMODO_CLIENT_SECRET || 'REDACTED_QUANTIMODO_CLIENT_SECRET',
    },
    github: {
        // We use this for mobile apps
        clientId: process.env.CONNECTOR_GITHUB_CLIENT_ID || "REDACTED_GITHUB_CLIENT_SECRET",
        clientSecret: process.env.CONNECTOR_GITHUB_CLIENT_SECRET || "REDACTED_GITHUB_CLIENT_ID",
        scopes: ['user:email', 'read:user', 'repo']
    },
    discord: {
        clientId: process.env.CONNECTOR_DISCORD_CLIENT_ID || "REDACTED_DISCORD_CLIENT_ID",
        clientSecret: process.env.CONNECTOR_DISCORD_CLIENT_SECRET || "REDACTED_DISCORD_CLIENT_SECRET",
    },
    getScopes(serviceName){
        let scopes = this[serviceName].scopes;
        return scopes;
    }
};
credentials.find = function (name) {
    return {
        clientID:     credentials[name].clientId,
        clientSecret:  credentials[name].clientSecret,
        callbackURL: `${urlHelper.websiteDomain}/auth/${name}/callback`,
        passReqToCallback: true
    }
}
module.exports = credentials
