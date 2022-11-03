const mongoose = require('mongoose');
const Facility = require('./Facility');
const User = require('./User');

const BookingSchema = mongoose.Schema({
    user: { type: mongoose.Types.ObjectId, ref: 'User' },
    facility: { type: mongoose.Types.ObjectId, ref: 'Facility' },
    courtNumber: { type: Number },
    startDateTime: { type: Number },
    endDateTime: { type: Number },
});

module.exports = mongoose.model('booking', BookingSchema);
