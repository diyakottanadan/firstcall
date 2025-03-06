const express = require('express');
const alertController = require('../controller/alert-controller');

const router = express.Router();

// Route to add alert
router.post('/addAlert', alertController.addAlert);

// Route to get alert by hospital ID
router.post('/getAlertByHospitalId', alertController.getAlertByHospitalId);

// Route to get alert by district
router.post('/getAlertByDistrict', alertController.getAlertByDistrict);

// Route to change alert status
router.post('/changeAlertStatus', alertController.changeAlertStatus);

module.exports = router;