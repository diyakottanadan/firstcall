const express= require('express');
const routes=express.Router();
const rescueController=require('../controller/rescue-controller');
routes.post('/register',rescueController.Register);
routes.post('/login',rescueController.login);
module.exports=routes;