/**
 * The MeasurementsController file is a very simple one, which does not need to be changed manually,
 * unless there's a case where business logic routes the request to an entity which is not
 * the service.
 * The heavy lifting of the Controller item is done in Request.js - that is where request
 * parameters are extracted and sent to the service, and where response is handled.
 */

const Controller = require('./Controller');
const service = require('../services/MeasurementsService');
const deleteMeasurement = async (request, response) => {
  await Controller.handleRequest(request, response, service.deleteMeasurement);
};

const getMeasurements = async (request, response) => {
  await Controller.handleRequest(request, response, service.getMeasurements);
};

const measurementExportRequest = async (request, response) => {
  await Controller.handleRequest(request, response, service.measurementExportRequest);
};

const measurementSpreadsheetUpload = async (request, response) => {
  await Controller.handleRequest(request, response, service.measurementSpreadsheetUpload);
};

const postMeasurements = async (request, response) => {
  await Controller.handleRequest(request, response, service.postMeasurements);
};

const updateMeasurement = async (request, response) => {
  await Controller.handleRequest(request, response, service.updateMeasurement);
};


module.exports = {
  deleteMeasurement,
  getMeasurements,
  measurementExportRequest,
  measurementSpreadsheetUpload,
  postMeasurements,
  updateMeasurement,
};
