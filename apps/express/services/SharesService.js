/* eslint-disable no-unused-vars */
const Service = require('./Service');

/**
* Delete share
* Remove access to user data for a given client_id associated with a given individual, app, or study
*
* clientIdToRevoke String Client id of the individual, study, or app that the user wishes to no longer have access to their data
* reason String Ex: I hate you! (optional)
* returns User
* */
const deleteShare = ({ clientIdToRevoke, reason }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        clientIdToRevoke,
        reason,
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
* Get Authorized Apps, Studies, and Individuals
* This is a list of individuals, apps, or studies with access to your measurements.
*
* userId BigDecimal User's id (optional)
* createdAt String When the record was first created. Use UTC ISO 8601 YYYY-MM-DDThh:mm:ss datetime format. Time zone should be UTC and not local. (optional)
* updatedAt String When the record was last updated. Use UTC ISO 8601 YYYY-MM-DDThh:mm:ss datetime format. Time zone should be UTC and not local. (optional)
* clientId String Your client id can be obtained by creating an app at https://builder.quantimo.do (optional)
* appVersion String Ex: 2.1.1.0 (optional)
* log String Username or email (optional)
* pwd String User password (optional)
* returns GetSharesResponse
* */
const getShares = ({ userId, createdAt, updatedAt, clientId, appVersion, log, pwd }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        userId,
        createdAt,
        updatedAt,
        clientId,
        appVersion,
        log,
        pwd,
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
* Delete share
* Invite someone to view your measurements
*
* body ShareInvitationBody Details about person to share with
* clientId String Your client id can be obtained by creating an app at https://builder.quantimo.do (optional)
* returns User
* */
const inviteShare = ({ body, clientId }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        body,
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

module.exports = {
  deleteShare,
  getShares,
  inviteShare,
};
