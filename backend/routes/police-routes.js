const express= require('express');
const routes=express.Router();
const policeController=require('../controller/police-controller');
routes.post('/register',policeController.Register);
routes.post('/login',policeController.login);
module.exports=routes;