/**
 * The UserController file is a very simple one, which does not need to be changed manually,
 * unless there's a case where business logic routes the request to an entity which is not
 * the service.
 * The heavy lifting of the Controller item is done in Request.js - that is where request
 * parameters are extracted and sent to the service, and where response is handled.
 */

const Controller = require('./Controller');
const service = require('../services/UserService');
const deleteUser = async (request, response) => {
  await Controller.handleRequest(request, response, service.deleteUser);
};

const getUser = async (request, response) => {
  await Controller.handleRequest(request, response, service.getUser);
};

const getUsers = async (request, response) => {
  await Controller.handleRequest(request, response, service.getUsers);
};

const postUser = async (request, response) => {
  await Controller.handleRequest(request, response, service.postUser);
};

const postUserSettings = async (request, response) => {
  await Controller.handleRequest(request, response, service.postUserSettings);
};


module.exports = {
  deleteUser,
  getUser,
  getUsers,
  postUser,
  postUserSettings,
};
