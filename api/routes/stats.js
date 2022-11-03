const express = require('express');
const Booking = require('../models/Booking');
const router = express.Router();

router.get('/consistency', async (req, res) => {
    //no.of active days send for all months and u can navigate thru diff months of the year and see calender
    //each streak = 30days
    let activeDays = [];
    const bookings = await Booking.find({ email: req.user.email });
    for (let i = 0; i < bookings.length; i++) {
        activeDays.push(bookings[i].startDateTime);
    }
    return res.json({
        success: true,
        data: activeDays,
        streak: streakCount,
        msg: 'Active Days List',
    });
});

router.get('/popularity', (req, res) => {
    //get bookings of particular sport and find out most frequent time ppl visit
    //show in bar graph form
});

router.get('/freqencySport', (req, res) => {
    let f1 = Booking.find({ email: req.user.email, 'facility.facilityId': 1 })
        .populate('facility')
        .count();
    let f2 = Booking.find({ email: req.user.email, 'facility.facilityId': 2 })
        .populate('facility')
        .count();
    let f3 = Booking.find({ email: req.user.email, 'facility.facilityId': 3 })
        .populate('facility')
        .count();
    let f4 = Booking.find({ email: req.user.email, 'facility.facilityId': 4 })
        .populate('facility')
        .count();
    return res.send({ f1, f2, f3, f4, success: true });
});

module.exports = router;
