/* eslint-disable no-unused-vars */
const Service = require('./Service');

/**
* Get a user access token
* Client provides authorization token obtained from /oauth/authorize to this endpoint and  receives an access token. Access token can then be used to query API endpoints. ### Request Access Token After user approves your access to the given scope form the https:/api.quantimo.do/oauth/authorize endpoint, you'll receive an authorization code to request an access token. This time make a `POST` request to `/oauth/access_token` with parameters including: * `grant_type` Can be `authorization_code` or `refresh_token` since we are getting the `access_token` for the first time we don't have a `refresh_token` so this must be `authorization_code`. * `code` Authorization code you received with the previous request. * `redirect_uri` Your application's redirect url. ### Refreshing Access Token Access tokens expire at some point, to continue using our api you need to refresh them with `refresh_token` you received along with the `access_token`. To do this make a `POST` request to `/oauth/access_token` with correct parameters, which are: * `grant_type` This time grant type must be `refresh_token` since we have it. * `clientId` Your application's client id. * `client_secret` Your application's client secret. * `refresh_token` The refresh token you received with the `access_token`. Every request you make to this endpoint will give you a new refresh token and make the old one expired. So you can keep getting new access tokens with new refresh tokens. ### Using Access Token Currently we support 2 ways for this, you can't use both at the same time. * Adding access token to the request header as `Authorization: Bearer {access_token}` * Adding to the url as a query parameter `?access_token={access_token}` You can read more about OAuth2 from [here](https://oauth.net/2/)
*
* grantUnderscoretype String Grant Type can be 'authorization_code' or 'refresh_token'
* code String Authorization code you received with the previous request.
* responseUnderscoretype String If the value is code, launches a Basic flow, requiring a POST to the token endpoint to obtain the tokens. If the value is token id_token or id_token token, launches an Implicit flow, requiring the use of Javascript at the redirect URI to retrieve tokens from the URI #fragment.
* scope String Scopes include basic, readmeasurements, and writemeasurements. The `basic` scope allows you to read user info (displayName, email, etc). The `readmeasurements` scope allows one to read a user's data. The `writemeasurements` scope allows you to write user data. Separate multiple scopes by a space.
* clientId String Your client id can be obtained by creating an app at https://builder.quantimo.do (optional)
* clientUnderscoresecret String This is the secret for your obtained clientId. We use this to ensure that only your application uses the clientId.  Obtain this by creating a free application at [https://builder.quantimo.do](https://builder.quantimo.do). (optional)
* redirectUnderscoreuri String The redirect URI is the URL within your client application that will receive the OAuth2 credentials. (optional)
* state String An opaque string that is round-tripped in the protocol; that is to say, it is returned as a URI parameter in the Basic flow, and in the URI (optional)
* no response value expected for this operation
* */
const getAccessToken = ({ grantUnderscoretype, code, responseUnderscoretype, scope, clientId, clientUnderscoresecret, redirectUnderscoreuri, state }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        grantUnderscoretype,
        code,
        responseUnderscoretype,
        scope,
        clientId,
        clientUnderscoresecret,
        redirectUnderscoreuri,
        state,
      }));
    } catch (e) {
      reject(Service.rejectResponse(
        e.message || 'Invalid input',
        e.status || 405,
      ));
    }
  },
);
/**
* Request Authorization Code
* You can implement OAuth2 authentication to your application using our **OAuth2** endpoints.  You need to redirect users to `/oauth/authorize` endpoint to get an authorization code and include the parameters below.   This page will ask the user if they want to allow a client's application to submit or obtain data from their QM account. It will redirect the user to the url provided by the client application with the code as a query parameter or error in case of an error. See the /oauth/access_token endpoint for the next steps.
*
* responseUnderscoretype String If the value is code, launches a Basic flow, requiring a POST to the token endpoint to obtain the tokens. If the value is token id_token or id_token token, launches an Implicit flow, requiring the use of Javascript at the redirect URI to retrieve tokens from the URI #fragment.
* scope String Scopes include basic, readmeasurements, and writemeasurements. The `basic` scope allows you to read user info (displayName, email, etc). The `readmeasurements` scope allows one to read a user's data. The `writemeasurements` scope allows you to write user data. Separate multiple scopes by a space.
* clientId String Your client id can be obtained by creating an app at https://builder.quantimo.do (optional)
* clientUnderscoresecret String This is the secret for your obtained clientId. We use this to ensure that only your application uses the clientId.  Obtain this by creating a free application at [https://builder.quantimo.do](https://builder.quantimo.do). (optional)
* redirectUnderscoreuri String The redirect URI is the URL within your client application that will receive the OAuth2 credentials. (optional)
* state String An opaque string that is round-tripped in the protocol; that is to say, it is returned as a URI parameter in the Basic flow, and in the URI (optional)
* no response value expected for this operation
* */
const getOauthAuthorizationCode = ({ responseUnderscoretype, scope, clientId, clientUnderscoresecret, redirectUnderscoreuri, state }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        responseUnderscoretype,
        scope,
        clientId,
        clientUnderscoresecret,
        redirectUnderscoreuri,
        state,
      }));
    } catch (e) {
      reject(Service.rejectResponse(
        e.message || 'Invalid input',
        e.status || 405,
      ));
    }
  },
);

module.exports = {
  getAccessToken,
  getOauthAuthorizationCode,
};
