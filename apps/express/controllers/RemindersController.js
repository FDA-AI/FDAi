/**
 * The RemindersController file is a very simple one, which does not need to be changed manually,
 * unless there's a case where business logic routes the request to an entity which is not
 * the service.
 * The heavy lifting of the Controller item is done in Request.js - that is where request
 * parameters are extracted and sent to the service, and where response is handled.
 */

const Controller = require('./Controller');
const service = require('../services/RemindersService');
const deleteTrackingReminder = async (request, response) => {
  await Controller.handleRequest(request, response, service.deleteTrackingReminder);
};

const getTrackingReminderNotifications = async (request, response) => {
  await Controller.handleRequest(request, response, service.getTrackingReminderNotifications);
};

const getTrackingReminders = async (request, response) => {
  await Controller.handleRequest(request, response, service.getTrackingReminders);
};

const postTrackingReminderNotifications = async (request, response) => {
  await Controller.handleRequest(request, response, service.postTrackingReminderNotifications);
};

const postTrackingReminders = async (request, response) => {
  await Controller.handleRequest(request, response, service.postTrackingReminders);
};


module.exports = {
  deleteTrackingReminder,
  getTrackingReminderNotifications,
  getTrackingReminders,
  postTrackingReminderNotifications,
  postTrackingReminders,
};
