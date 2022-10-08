const express = require('express');
const router = express.Router();
const Booking = requrie('../models/Booking');

router.get('/consistency', async (req, res) => {
    //no.of active days send for all months and u can navigate thru diff months of the year and see calender
});

router.get('/popularity', (req, res) => {
    //get bookings of particular sport and find out most frequent time ppl visit
    //show in bar graph form
});

module.exports = router;
