/* eslint-disable no-unused-vars */
const Service = require('./Service');

/**
* Get NotificationPreferences
* Get NotificationPreferences
*
* no response value expected for this operation
* */
const getNotificationPreferences = () => new Promise(
  async (resolve, reject) => {
    try {
      resolve(Service.successResponse({
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
* Post DeviceTokens
* Post user token for Android, iOS, or web push notifications
*
* body DeviceToken The platform and token
* no response value expected for this operation
* */
const postDeviceToken = ({ body }) => new Promise(
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
  getNotificationPreferences,
  postDeviceToken,
};
