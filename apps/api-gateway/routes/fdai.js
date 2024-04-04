const express = require('express');
const stringHelper = require('../utils/stringHelper');
const authHelper = require('../utils/authHelper');
const router = express.Router();
const userService = require('../services/userService');

router.get('fdai/user', async function getUser(req, res) {
    const yourUser = req.user;
    const fdaiUser = await userService.getOrCreateFdaiUser(yourUser.id);
    res.json(fdaiUser);
});

const measurementsService = require('../services/measurementsService');
// GET /measurements
router.get('/fdai/measurements', async (req, res) => {
  try {
    const params = req.query;
    const measurements = await measurementsService.getMeasurements(params);
    res.json(measurements);
  } catch (error) {
    console.error('Error getting measurements:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// POST /measurements
router.post('/fdai/measurements', async (req, res) => {
  try {
    const body = req.body;
    const response = await measurementsService.postMeasurements(body);
    res.status(201).json(response);
  } catch (error) {
    console.error('Error posting measurements:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// POST /measurements/update
router.post('/fdai/measurements/update', async (req, res) => {
  try {
    const body = req.body;
    const response = await measurementsService.updateMeasurement(body);
    res.json(response);
  } catch (error) {
    console.error('Error updating measurement:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// DELETE /measurements/delete
router.delete('/fdai/measurements/delete', async (req, res) => {
  try {
    const response = await measurementsService.deleteMeasurement();
    res.json(response);
  } catch (error) {
    console.error('Error deleting measurement:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});


module.exports = router;
