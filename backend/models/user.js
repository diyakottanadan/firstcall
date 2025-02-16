const mongoose= require('mongoose');
var userSchema= new mongoose.Schema({
    name:{
        type:String,
        required:true,
        minlength:3,
        maxlength:30
    },
    email:{
        type:String,
        required :true,
        unique:true
    },
    phone:{
        type:Number,
        required:true
    },
    password:{
        type:String,
        required:true
    },
    district:{
        type:String,
    },
    place:{
        type:String,
    },
    usertype:{
        type:String,
        // default:"user"
    }
})
module.exports = mongoose.model('User',userSchema);