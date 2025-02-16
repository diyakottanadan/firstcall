const mongoose = require('mongoose');
var workShopSchema = new mongoose.Schema({
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
    license: {
        type: String,
        required: true,
    },
    userid: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User'
    },
    status: {
        type: String,
        default: "pending"
    }
})
module.exports = mongoose.model('Workshop', workShopSchema);