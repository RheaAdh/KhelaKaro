const mongoose = require('mongoose');

const FacilitySchema = mongoose.Schema({
    name: String,
    count: Number,
    startTime: Date,
    endTime: Date,
});

module.exports = mongoose.model('facility', FacilitySchema);
