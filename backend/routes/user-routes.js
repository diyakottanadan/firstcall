const express= require('express');
const routes=express.Router();
const userController=require('../controller/user-controller');
routes.post('/register',userController.Register);
routes.post('/login',userController.login);
routes.get('/pending-hospitals', userController.getAllPendingHospital);
routes.get('/pending-workshops', userController.getAllPendingWorkshop);
routes.post('/approve-hospital', userController.approveHospital);
routes.post('/approve-workshop', userController.approveWorkshop);
module.exports=routes;
