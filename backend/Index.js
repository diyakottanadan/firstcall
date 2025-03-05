const port = 3000;
require("dotenv").config();
const mongoose = require("mongoose");
const express= require('express')
const app= express()
const bodyParser = require("body-parser");
const cookieParser = require("cookie-parser");
const cors = require("cors");
const userRoutes=require('./routes/user-routes');
const accidentRoutes=require('./routes/accident-routes');

//db coonection
mongoose
.connect(process.env.DATABASE,{
    useNewUrlParser:true,
    useUnifiedTopology:true,
}).then (()=>{
    console.log("DB CONNECTED")
})

//Middlewares
app.use(bodyParser.json({limit:'10mb'}));
app.use(cookieParser());
app.use(cors());
app.use('/api',userRoutes);
app.use('/api',accidentRoutes);

app.get('/',(req,res)=>{
    res.send('hello world')
})
app.get('/login',(req,res)=>{
    res.send('welcome')
})
app.listen(port,()=>{
    console.log(`app listening on port ${port}`)
})
