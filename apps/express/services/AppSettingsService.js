/* eslint-disable no-unused-vars */
const Service = require('./Service');

/**
* Get client app settings
* Get the settings for your application configurable at https://builder.quantimo.do
*
* clientId String Your client id can be obtained by creating an app at https://builder.quantimo.do (optional)
* clientUnderscoresecret String This is the secret for your obtained clientId. We use this to ensure that only your application uses the clientId.  Obtain this by creating a free application at [https://builder.quantimo.do](https://builder.quantimo.do). (optional)
* returns AppSettingsResponse
* */
const getAppSettings = ({ clientId, clientUnderscoresecret }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        clientId,
        clientUnderscoresecret,
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
  getAppSettings,
};
