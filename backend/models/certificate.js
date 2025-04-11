const mongoose = require('mongoose');
const {ObjectId}=require("mongodb");
const user = require('./user');
const certificateSchema = new mongoose.Schema({
    policeid:{
        type: ObjectId,
        required: true,
        ref:"User"
    },
    userid:{
        type: ObjectId,
        required: true,
        ref:"User"
    },
    adhaar:{
        type:String,
    },
    purpose:{
        type:String,
    },
    full_name:{
        type:String,
    },
    address:{
        type:String,
    },
    village:{
        type:String,
    },
    muncipality:{
        type:String,
    },
    occupation:{
        type:String,
    },
    phone_number:{
        type:String,
    },
    remarks:{
        type:String,
    },
    status: {
        type: String,
        default: 'Pending'
    },
    createdAt: {
        type: Date,
        default: Date.now
    },
    updatedAt: {
        type: Date,
        default: Date.now
    }
});

certificateSchema.pre('save', function(next) {
    this.updatedAt = Date.now();
    next();
});

const Certificate = mongoose.model('Certificate', certificateSchema);

module.exports = Certificate;