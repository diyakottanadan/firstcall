
var mongoose = require("mongoose");
const {ObjectId}=require("mongodb")
var workshopRequestSchema=mongoose.Schema({
    userid:{
        type: ObjectId,
        required: true,
        ref:"User"
    },
    workshopid:{
        type: ObjectId,
        required: true,
        ref:"User"
    },
    image:{
        type:String,
    },
    subject:{
        type:String,
    },
    content:{
        type:String,
    },
    reply:{
        type:String,
    },
    location:{
        type:String,
    },
    timestamp:{
        type:String,
        default:Date.now()
    },
    status:{
        type:String,
        default:"Pending"
    }
})
module.exports=mongoose.model("WorkshopRequest",workshopRequestSchema);