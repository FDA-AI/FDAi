/* eslint-disable no-unused-vars */
const Service = require('./Service');

/**
* Obtain a token from 3rd party data source
* Attempt to obtain a token from the data provider, store it in the database. With this, the connector to continue to obtain new user data until the token is revoked.
*
* connectorName String Lowercase system name of the source application or device. Get a list of available connectors from the /v3/connectors/list endpoint.
* userId BigDecimal User's id (optional)
* no response value expected for this operation
* */
const connectConnector = ({ connectorName, userId }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        connectorName,
        userId,
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
* Delete stored connection info
* The disconnect method deletes any stored tokens or connection information from the connectors database.
*
* connectorName String Lowercase system name of the source application or device. Get a list of available connectors from the /v3/connectors/list endpoint.
* no response value expected for this operation
* */
const disconnectConnector = ({ connectorName }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        connectorName,
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
* List of Connectors
* A connector pulls data from other data providers using their API or a screenscraper. Returns a list of all available connectors and information about them such as their id, name, whether the user has provided access, logo url, connection instructions, and the update history.
*
* clientId String Your client id can be obtained by creating an app at https://builder.quantimo.do (optional)
* returns GetConnectorsResponse
* */
const getConnectors = ({ clientId }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        clientId,
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
* Get embeddable connect javascript
* Get embeddable connect javascript. Usage:   - Embedding in applications with popups for 3rd-party authentication windows.     Use `qmSetupInPopup` function after connecting `connect.js`.   - Embedding in applications with popups for 3rd-party authentication windows.     Requires a selector to block. It will be embedded in this block.     Use `qmSetupOnPage` function after connecting `connect.js`.   - Embedding in mobile applications without popups for 3rd-party authentication.     Use `qmSetupOnMobile` function after connecting `connect.js`.     If using in a Cordova application call  `qmSetupOnIonic` function after connecting `connect.js`.
*
* clientId String Your client id can be obtained by creating an app at https://builder.quantimo.do (optional)
* no response value expected for this operation
* */
const getIntegrationJs = ({ clientId }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        clientId,
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
* Mobile connect page
* This page is designed to be opened in a webview.  Instead of using popup authentication boxes, it uses redirection. You can include the user's access_token as a URL parameter like https://api.quantimo.do/api/v3/connect/mobile?access_token=123
*
* userId BigDecimal User's id (optional)
* no response value expected for this operation
* */
const getMobileConnectPage = ({ userId }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        userId,
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
* Sync with data source
* The update method tells the QM Connector Framework to check with the data provider (such as Fitbit or MyFitnessPal) and retrieve any new measurements available.
*
* connectorName String Lowercase system name of the source application or device. Get a list of available connectors from the /v3/connectors/list endpoint.
* userId BigDecimal User's id (optional)
* no response value expected for this operation
* */
const updateConnector = ({ connectorName, userId }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        connectorName,
        userId,
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
  connectConnector,
  disconnectConnector,
  getConnectors,
  getIntegrationJs,
  getMobileConnectPage,
  updateConnector,
};
