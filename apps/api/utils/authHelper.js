const db = require("../db");
const qm = require("../../ionic/src/js/qmHelpers");
const fetch = require('node-fetch');
const credentials = require("./credentials");
global.fetch = fetch
global.Headers = fetch.Headers;
const dataSources = require("../data/data-sources");
function login(dbUser, request, accessToken, refreshToken, profile, connectorName, done){
  let qmUser = qm.stringHelper.camelizeObjectKeys(dbUser);
  return db.createAccessToken(dbUser, request).then((token) => {
    qmUser.accessToken = token.access_token;
    qm.userHelper.setUser(qmUser);
    request.session.qmUser = qmUser;
    storeConnectorCredentials(request, accessToken, refreshToken, profile, connectorName).then((connection) => {
      console.log("connection", connection);
    });
    return done(null, dbUser);
  });
}
function loginOrCreateUser(user, request, accessToken, refreshToken, profile, connectorName, done){
  if(user){
    return login(user, request, accessToken, refreshToken, profile, connectorName, done);
  }
  return db.createUser(profile).then((user) => {
    return login(user, request, accessToken, refreshToken, profile, connectorName, done);
  });
}
async function handleSocialLogin(request, accessToken, refreshToken, profile, done, connectorName) {
  const meta = await db.prisma.wp_usermeta.findFirst({
    where: {
      meta_key: connectorName + "_id",
      meta_value: profile.id,
    }
  });
  if(meta){
    let user = await db.findUserById(meta.user_id);
    if(user){
      return loginOrCreateUser(user, request, accessToken, refreshToken, profile, connectorName, done);
    }
  }
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
  return db.findUserByEmail(email).then((user) => {
    return loginOrCreateUser(user, request, accessToken, refreshToken, profile, connectorName, done);
  });
}

async function storeConnectorCredentials(request, accessToken, refreshToken, profile, connectorName){
  let connectorResponse = {
    accessToken: accessToken,
    refreshToken: refreshToken,
    profile: profile,
  };
  const connectorUserId = profile.id;
  profile.forEach((key, value) => {
    const meta = db.prisma.wp_usermeta.create({
      data: {
        meta_key: connectorName + "_" + key,
        meta_value: value,
        user_id: user.id,
      }
    });
  })
  const connection = await createConnection(connectorResponse, connectorName);
  qm.api.post('api/v3/connectors/' + connectorName + '/connect?noRedirect=true',
    { connectorCredentials: connectorResponse },
    function(response){
      qmLog.authDebug("postConnectorCredentials got response:", response, response);
    }, function(error){
      qmLog.error("postConnectorCredentials error: ", error, {
        errorResponse: error,
        connectorName: connectorName
      });
    });
}

async function createConnection(connectorResponse, connectorName){
  const connector = dataSources[connectorName];
  const connection  = await db.prisma.connections.create({
    data: {
      user_id: user.id,
      connector_id: connector.id,
      update_status: "WAITING",
      connectorName: connectorName,
      client_id: credentials.quantimodo.clientId,
      update_requested_at: new Date(),
      credentials: connectorResponse,
      connect_status: "CONNECTED",
    }
  })
  return connection;
}

module.exports = {
  handleSocialLogin
}
