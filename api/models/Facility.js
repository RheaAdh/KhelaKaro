const mongoose = require('mongoose');

const FacilitySchema = mongoose.Schema({
    facilityId: Number,
    name: String,
    count: Number,
});

module.exports = mongoose.model('facility', FacilitySchema);
