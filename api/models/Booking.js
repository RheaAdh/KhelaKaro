const mongoose = require('mongoose');
const Facility = require('./Facility');
const User = require('./User');

const BookingSchema = mongoose.Schema({
    user: User,
    facility: Facility,
});

module.exports = mongoose.model('booking', BookingSchema);
