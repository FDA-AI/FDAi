const fetch = require('node-fetch');
const envHelper = require('../utils/envHelper');

const baseUrl = 'https://safe.fdai.earth/api/v3/measurements';

const measurementsService = {
  async getMeasurements(params) {
    const url = new URL(baseUrl);
    Object.entries(params).forEach(([key, value]) => {
      url.searchParams.append(key, value);
    });

    const response = await fetch(url, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
        'X-Client-Id': envHelper.getRequiredEnv('FDAI_CLIENT_ID'),
        'X-Client-Secret': envHelper.getRequiredEnv('FDAI_CLIENT_SECRET'),
      },
    });

    return await response.json();
  },

  async postMeasurements(body) {
    const response = await fetch(`${baseUrl}/post`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-Client-Id': envHelper.getRequiredEnv('FDAI_CLIENT_ID'),
        'X-Client-Secret': envHelper.getRequiredEnv('FDAI_CLIENT_SECRET'),
      },
      body: JSON.stringify(body),
    });

    return await response.json();
  },

  async updateMeasurement(body) {
    const response = await fetch(`${baseUrl}/update`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-Client-Id': envHelper.getRequiredEnv('FDAI_CLIENT_ID'),
        'X-Client-Secret': envHelper.getRequiredEnv('FDAI_CLIENT_SECRET'),
      },
      body: JSON.stringify(body),
    });

    return await response.json();
  },

  async deleteMeasurement() {
    const response = await fetch(`${baseUrl}/delete`, {
      method: 'DELETE',
      headers: {
        'Content-Type': 'application/json',
        'X-Client-Id': envHelper.getRequiredEnv('FDAI_CLIENT_ID'),
        'X-Client-Secret': envHelper.getRequiredEnv('FDAI_CLIENT_SECRET'),
      },
    });

    return await response.json();
  },
};

module.exports = measurementsService;
