const mongoose = require('mongoose');
const {ObjectId}=require("mongodb")
const alertSchema = new mongoose.Schema({
    hospitalid:{
        type: ObjectId,
        required: true,
        ref:"User"
    },
    title: {
        type: String,
        required: true
    },
    message: {
        type: String,
        required: true
    },
    level: {
        type: String,
       
        required: true
    },
    status: {
        type: String,
        enum: ['Active', 'Resolved'],
        default: 'Active'
    },
    district:{
        type: String,
        required: true
    },
    city:{
        type: String,
        required: true
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

alertSchema.pre('save', function(next) {
    this.updatedAt = Date.now();
    next();
});

const Alert = mongoose.model('Alert', alertSchema);

module.exports = Alert;