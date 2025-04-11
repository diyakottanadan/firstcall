const express = require('express');
const certificateController = require('../controller/certificate-controller');

const router = express.Router();

// Route to add certificate
router.post('/addCertificate', certificateController.addCertificate);

// Route to get certificate by police ID
router.post('/getCertificateByPoliceId', certificateController.getCertificateByPoliceId);

// Route to get certificate by user ID
router.post('/getCertificateByUserId', certificateController.getCertificateByUserId);

// Route to get certificate by ID
router.post('/getCertificateById', certificateController.getCertificateById);

// Route to update certificate status
router.post('/updateCertificateStatus', certificateController.updateCertificateStatus);

module.exports = router;