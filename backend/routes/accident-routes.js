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

module.exports = router;