const express = require('express');
const accidentController = require('../controller/accident-controller');

const router = express.Router();

// Route to add a new accident report
router.post('/add-accident', accidentController.addAccidentReport);

// Route to get accident reports by user ID
router.get('/get-accident-by-userid', accidentController.getAccidentReportByUserId);

// Route to get accident reports by police ID
router.get('/get-accident-by-policeid', accidentController.getAccidentReportByPoliceId);

// Route to reply to an accident report
router.post('/add-reply-accident', accidentController.replyToAccidentReport);

// Route to get police by district
router.get('/get-police-by-district', accidentController.getPoliceByDistrict);

// Route to get forest by district
router.get('/get-forest-by-district', accidentController.getForestByDistrict);

// Route to get rescu by district
router.get('/get-rescue-by-district', accidentController.getRescueByDistrict);

module.exports = router;