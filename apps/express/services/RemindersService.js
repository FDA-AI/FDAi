/* eslint-disable no-unused-vars */
const Service = require('./Service');

/**
* Delete Tracking Reminder
* Stop getting notifications to record data for a variable.  Previously recorded measurements will be preserved.
*
* userId BigDecimal User's id (optional)
* returns CommonResponse
* */
const deleteTrackingReminder = ({ userId }) => new Promise(
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
* Get specific tracking reminder notifications
* Specific tracking reminder notification instances that still need to be tracked.
*
* sort String Sort by one of the listed field names. If the field name is prefixed with `-`, it will sort in descending order. (optional)
* userId BigDecimal User's id (optional)
* createdAt String When the record was first created. Use UTC ISO 8601 YYYY-MM-DDThh:mm:ss datetime format. Time zone should be UTC and not local. (optional)
* updatedAt String When the record was last updated. Use UTC ISO 8601 YYYY-MM-DDThh:mm:ss datetime format. Time zone should be UTC and not local. (optional)
* limit Integer The LIMIT is used to limit the number of results returned. So if youhave 1000 results, but only want to the first 10, you would set this to 10 and offset to 0. The maximum limit is 200 records. (optional)
* offset Integer OFFSET says to skip that many rows before beginning to return rows to the client. OFFSET 0 is the same as omitting the OFFSET clause.If both OFFSET and LIMIT appear, then OFFSET rows are skipped before starting to count the LIMIT rows that are returned. (optional)
* variableCategoryName String Ex: Emotions, Treatments, Symptoms... (optional)
* reminderTime String Ex: (lt)2017-07-31 21:43:26 (optional)
* clientId String Your client id can be obtained by creating an app at https://builder.quantimo.do (optional)
* onlyPast Boolean Ex: 1 (optional)
* includeDeleted Boolean Include deleted variables (optional)
* returns GetTrackingReminderNotificationsResponse
* */
const getTrackingReminderNotifications = ({ sort, userId, createdAt, updatedAt, limit, offset, variableCategoryName, reminderTime, clientId, onlyPast, includeDeleted }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        sort,
        userId,
        createdAt,
        updatedAt,
        limit,
        offset,
        variableCategoryName,
        reminderTime,
        clientId,
        onlyPast,
        includeDeleted,
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
* Get repeating tracking reminder settings
* Users can be reminded to track certain variables at a specified frequency with a default value.
*
* userId BigDecimal User's id (optional)
* variableCategoryName String Ex: Emotions, Treatments, Symptoms... (optional)
* createdAt String When the record was first created. Use UTC ISO 8601 YYYY-MM-DDThh:mm:ss datetime format. Time zone should be UTC and not local. (optional)
* updatedAt String When the record was last updated. Use UTC ISO 8601 YYYY-MM-DDThh:mm:ss datetime format. Time zone should be UTC and not local. (optional)
* limit Integer The LIMIT is used to limit the number of results returned. So if youhave 1000 results, but only want to the first 10, you would set this to 10 and offset to 0. The maximum limit is 200 records. (optional)
* offset Integer OFFSET says to skip that many rows before beginning to return rows to the client. OFFSET 0 is the same as omitting the OFFSET clause.If both OFFSET and LIMIT appear, then OFFSET rows are skipped before starting to count the LIMIT rows that are returned. (optional)
* sort String Sort by one of the listed field names. If the field name is prefixed with `-`, it will sort in descending order. (optional)
* clientId String Your client id can be obtained by creating an app at https://builder.quantimo.do (optional)
* appVersion String Ex: 2.1.1.0 (optional)
* returns List
* */
const getTrackingReminders = ({ userId, variableCategoryName, createdAt, updatedAt, limit, offset, sort, clientId, appVersion }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        userId,
        variableCategoryName,
        createdAt,
        updatedAt,
        limit,
        offset,
        sort,
        clientId,
        appVersion,
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
* Snooze, skip, or track a tracking reminder notification
* Snooze, skip, or track a tracking reminder notification
*
* body List Id of the tracking reminder notification to be snoozed
* userId BigDecimal User's id (optional)
* clientId String Your client id can be obtained by creating an app at https://builder.quantimo.do (optional)
* returns CommonResponse
* */
const postTrackingReminderNotifications = ({ body, userId, clientId }) => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
        body,
        userId,
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
* Store a Tracking Reminder
* This is to enable users to create reminders to track a variable with a default value at a specified frequency
*
* body List TrackingReminder that should be stored
* returns PostTrackingRemindersResponse
* */
const postTrackingReminders = ({ body }) => new Promise(
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

module.exports = {
  deleteTrackingReminder,
  getTrackingReminderNotifications,
  getTrackingReminders,
  postTrackingReminderNotifications,
  postTrackingReminders,
};
