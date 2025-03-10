const express= require('express');
const routes=express.Router();
const workshopController=require('../controller/workshop-controller');
routes.post('/viewWorkshopUserByDistrict',workshopController.viewWorkshopUserByDistrict);
routes.post('/addWorkshopRequest',workshopController.addWorkshopRequest);
routes.post('/getWorkshopRequestByUserId',workshopController.getWorkshopRequestByUserId);
routes.post('/getRequestByWorkshipId',workshopController.getRequestByWorkshipId);
routes.post('/replyToWorkshopRequest',workshopController.replyToWorkshopRequest);


module.exports=routes;
