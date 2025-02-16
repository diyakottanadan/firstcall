const mongoose = require('mongoose');
var rescueSchema = new mongoose.Schema({
    country: {
        type: String,
        default: "India"
    },
    district: {
        type: String,
        required: true
    },
    state: {
        type: String,
        default: "Kerala"
    },
    city: {
        type: String,
        required: true,
    },
    userid: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User'
    }
})
module.exports = mongoose.model('Rescue', rescueSchema);