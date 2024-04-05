/**
 * The StudiesController file is a very simple one, which does not need to be changed manually,
 * unless there's a case where business logic routes the request to an entity which is not
 * the service.
 * The heavy lifting of the Controller item is done in Request.js - that is where request
 * parameters are extracted and sent to the service, and where response is handled.
 */

const Controller = require('./Controller');
const service = require('../services/StudiesService');
const createStudy = async (request, response) => {
  await Controller.handleRequest(request, response, service.createStudy);
};

const deleteVote = async (request, response) => {
  await Controller.handleRequest(request, response, service.deleteVote);
};

const getOpenStudies = async (request, response) => {
  await Controller.handleRequest(request, response, service.getOpenStudies);
};

const getStudies = async (request, response) => {
  await Controller.handleRequest(request, response, service.getStudies);
};

const getStudiesCreated = async (request, response) => {
  await Controller.handleRequest(request, response, service.getStudiesCreated);
};

const getStudiesJoined = async (request, response) => {
  await Controller.handleRequest(request, response, service.getStudiesJoined);
};

const getStudy = async (request, response) => {
  await Controller.handleRequest(request, response, service.getStudy);
};

const joinStudy = async (request, response) => {
  await Controller.handleRequest(request, response, service.joinStudy);
};

const postVote = async (request, response) => {
  await Controller.handleRequest(request, response, service.postVote);
};

const publishStudy = async (request, response) => {
  await Controller.handleRequest(request, response, service.publishStudy);
};


module.exports = {
  createStudy,
  deleteVote,
  getOpenStudies,
  getStudies,
  getStudiesCreated,
  getStudiesJoined,
  getStudy,
  joinStudy,
  postVote,
  publishStudy,
};
