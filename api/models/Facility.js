const mongoose = require('mongoose');

const FacilitySchema = mongoose.Schema({
    name: String,
    count: Number,
});

module.exports = mongoose.model('facility', FacilitySchema);
