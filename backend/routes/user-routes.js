const express= require('express');
const routes=express.Router();
const userController=require('../controller/user-controller');
routes.post('/register',userController.Register);
routes.post('/login',userController.login);
routes.get('/pending-hospitals', userController.getAllPendingHospital);
routes.get('/pending-workshops', userController.getAllPendingWorkshop);
routes.post('/approve-hospital', userController.approveHospital);
routes.post('/approve-workshop', userController.approveWorkshop);
routes.post('/getuser',userController.findUser)

routes.post('/updatePhoneNumber',userController.updatePhoneNumber)
routes.post('/updateEmail',userController.updateEmail)
routes.post('/updatePassword',userController.updatePassword)
routes.post('/findUserByEmail',userController.findUserByEmail)
module.exports=routes;
