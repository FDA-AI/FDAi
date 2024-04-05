/* eslint-disable no-unused-vars */
const Service = require('./Service');

/**
* Delete user
* Delete user account. Only the client app that created a user can delete that user.
*
* reason String Ex: I hate you!
* clientId String Your client id can be obtained by creating an app at https://builder.quantimo.do (optional)
* returns CommonResponse
* */
const deleteUser = ({ reason, clientId }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        reason,
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
* Get user info
* Returns user info.  If no userId is specified, returns info for currently authenticated user
*
* userId BigDecimal User's id (optional)
* createdAt String When the record was first created. Use UTC ISO 8601 YYYY-MM-DDThh:mm:ss datetime format. Time zone should be UTC and not local. (optional)
* updatedAt String When the record was last updated. Use UTC ISO 8601 YYYY-MM-DDThh:mm:ss datetime format. Time zone should be UTC and not local. (optional)
* limit Integer The LIMIT is used to limit the number of results returned. So if youhave 1000 results, but only want to the first 10, you would set this to 10 and offset to 0. The maximum limit is 200 records. (optional)
* offset Integer OFFSET says to skip that many rows before beginning to return rows to the client. OFFSET 0 is the same as omitting the OFFSET clause.If both OFFSET and LIMIT appear, then OFFSET rows are skipped before starting to count the LIMIT rows that are returned. (optional)
* sort String Sort by one of the listed field names. If the field name is prefixed with `-`, it will sort in descending order. (optional)
* clientId String Your client id can be obtained by creating an app at https://builder.quantimo.do (optional)
* appVersion String Ex: 2.1.1.0 (optional)
* clientUserId Integer Ex: 74802 (optional)
* log String Username or email (optional)
* pwd String User password (optional)
* includeAuthorizedClients Boolean Return list of apps, studies, and individuals with access to user data (optional)
* returns User
* */
const getUser = ({ userId, createdAt, updatedAt, limit, offset, sort, clientId, appVersion, clientUserId, log, pwd, includeAuthorizedClients }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        userId,
        createdAt,
        updatedAt,
        limit,
        offset,
        sort,
        clientId,
        appVersion,
        clientUserId,
        log,
        pwd,
        includeAuthorizedClients,
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
* Get users who shared data
* Returns users who have granted access to their data
*
* userId BigDecimal User's id (optional)
* createdAt String When the record was first created. Use UTC ISO 8601 YYYY-MM-DDThh:mm:ss datetime format. Time zone should be UTC and not local. (optional)
* updatedAt String When the record was last updated. Use UTC ISO 8601 YYYY-MM-DDThh:mm:ss datetime format. Time zone should be UTC and not local. (optional)
* limit Integer The LIMIT is used to limit the number of results returned. So if youhave 1000 results, but only want to the first 10, you would set this to 10 and offset to 0. The maximum limit is 200 records. (optional)
* offset Integer OFFSET says to skip that many rows before beginning to return rows to the client. OFFSET 0 is the same as omitting the OFFSET clause.If both OFFSET and LIMIT appear, then OFFSET rows are skipped before starting to count the LIMIT rows that are returned. (optional)
* sort String Sort by one of the listed field names. If the field name is prefixed with `-`, it will sort in descending order. (optional)
* clientId String Your client id can be obtained by creating an app at https://builder.quantimo.do (optional)
* appVersion String Ex: 2.1.1.0 (optional)
* clientUserId Integer Ex: 74802 (optional)
* log String Username or email (optional)
* pwd String User password (optional)
* returns UsersResponse
* */
const getUsers = ({ userId, createdAt, updatedAt, limit, offset, sort, clientId, appVersion, clientUserId, log, pwd }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        userId,
        createdAt,
        updatedAt,
        limit,
        offset,
        sort,
        clientId,
        appVersion,
        clientUserId,
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
* Create or update user
* Include your your system's user id as the clientUserId to make sure you can identify the user in your system. If the user already exists, the user will be updated with the new information.
*
* body UserPostBody User info to update
* no response value expected for this operation
* */
const postUser = ({ body }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        body,
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
* Post UserSettings
* Post UserSettings
*
* body User User settings to update
* clientId String Your client id can be obtained by creating an app at https://builder.quantimo.do (optional)
* returns PostUserSettingsResponse
* */
const postUserSettings = ({ body, clientId }) => new Promise(
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
  deleteUser,
  getUser,
  getUsers,
  postUser,
  postUserSettings,
};
