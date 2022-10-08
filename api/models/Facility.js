const mongoose = require('mongoose');

const FacilitySchema = mongoose.Schema({
    name: String,
});

module.exports = mongoose.model('facility', FacilitySchema);
