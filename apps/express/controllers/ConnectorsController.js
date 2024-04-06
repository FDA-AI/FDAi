/**
 * The ConnectorsController file is a very simple one, which does not need to be changed manually,
 * unless there's a case where business logic routes the request to an entity which is not
 * the service.
 * The heavy lifting of the Controller item is done in Request.js - that is where request
 * parameters are extracted and sent to the service, and where response is handled.
 */

const Controller = require('./Controller');
const service = require('../services/ConnectorsService');
const connectConnector = async (request, response) => {
  await Controller.handleRequest(request, response, service.connectConnector);
};

const disconnectConnector = async (request, response) => {
  await Controller.handleRequest(request, response, service.disconnectConnector);
};

const getConnectors = async (request, response) => {
  await Controller.handleRequest(request, response, service.getConnectors);
};

const getIntegrationJs = async (request, response) => {
  await Controller.handleRequest(request, response, service.getIntegrationJs);
};

const getMobileConnectPage = async (request, response) => {
  await Controller.handleRequest(request, response, service.getMobileConnectPage);
};

const updateConnector = async (request, response) => {
  await Controller.handleRequest(request, response, service.updateConnector);
};


module.exports = {
  connectConnector,
  disconnectConnector,
  getConnectors,
  getIntegrationJs,
  getMobileConnectPage,
  updateConnector,
};
