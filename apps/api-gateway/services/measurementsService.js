const fetch = require('node-fetch');

if (!process.env.DFDA_CLIENT_ID || !process.env.DFDA_CLIENT_SECRET) {
  throw new Error('Missing DFDA_CLIENT_ID or DFDA_CLIENT_SECRET. Please get them at https://builder.dfda.earth/app/public/#/app/configuration');
}

const measurementsService = {
  async getMeasurements(params) {
    const url = new URL('https://safe.dfda.earth/api/v3/measurements');
    Object.entries(params).forEach(([key, value]) => {
      url.searchParams.append(key, value);
    });

    const response = await fetch(url, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
        'X-Client-Id': process.env.DFDA_CLIENT_ID,
        'X-Client-Secret': process.env.DFDA_CLIENT_SECRET,
      },
    });

    return await response.json();
  },

  async postMeasurements(body) {
    const response = await fetch(`https://safe.dfda.earth/api/v3/measurements/post`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-Client-Id': process.env.DFDA_CLIENT_ID,
        'X-Client-Secret': process.env.DFDA_CLIENT_SECRET,
      },
      body: JSON.stringify(body),
    });

    return await response.json();
  },

  async updateMeasurement(body) {
    const response = await fetch(`https://safe.dfda.earth/api/v3/measurements/update`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-Client-Id': process.env.DFDA_CLIENT_ID,
        'X-Client-Secret': process.env.DFDA_CLIENT_SECRET,
      },
      body: JSON.stringify(body),
    });

    return await response.json();
  },

  async deleteMeasurement() {
    const response = await fetch(`https://safe.dfda.earth/api/v3/measurements/delete`, {
      method: 'DELETE',
      headers: {
        'Content-Type': 'application/json',
        'X-Client-Id': process.env.DFDA_CLIENT_ID,
        'X-Client-Secret': process.env.DFDA_CLIENT_SECRET,
      },
    });

    return await response.json();
  },
};

module.exports = measurementsService;
