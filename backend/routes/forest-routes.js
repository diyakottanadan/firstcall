const express= require('express');
const routes=express.Router();
const forestController=require('../controller/forest-controller');
routes.post('/register',forestController.Register);
routes.post('/login',forestController.login);
module.exports=routes;