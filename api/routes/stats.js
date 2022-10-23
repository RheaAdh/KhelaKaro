const express = require('express');
const Booking = require('../models/Booking');
const router = express.Router();

router.get('/consistency', async (req, res) => {
    //no.of active days send for all months and u can navigate thru diff months of the year and see calender
    let activeDays = [];
    const bookings = await Booking.find({ user: req.user._id });
    for (let i = 0; i < bookings.length; i++) {
        activeDays.push(bookings[i].startDateTime);
    }
    return res.json({
        success: true,
        data: activeDays,
        msg: 'Active Days List',
    });
});

router.get('/popularity', (req, res) => {
    //get bookings of particular sport and find out most frequent time ppl visit
    //show in bar graph form
});

module.exports = router;
