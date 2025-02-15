const express= require('express');
const routes=express.Router();
const hospitalController=require('../controller/hospital-controller');
routes.post('/register',hospitalController.Register);
routes.post('/login',hospitalController.login);
module.exports=routes;