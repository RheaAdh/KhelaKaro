const express = require('express');
const Facility = require('../models/Facility');
const Booking = require('../models/Booking');

const router = express.Router();

router.post('/profile', async (req, res) => {
    try {
        //array of dates for each facility by logged in person in descending order of dates
        let s1 = [];
        let s2 = [];
        let s3 = [];
        let s4 = [];

        for (let sport = 1; sport <= 4; sport++) {
            const facility = await Facility.findOne({ facilityId: sport });
            const bookings = await Booking.find({
                user: req.user._id,
                facility: facility._id,
            });
            for (let i = 0; i < bookings.length; i++) {
                if (sport == 1) s1.push(bookings[i].startDateTime);
                else if (sport == 2) s2.push(bookings[i].startDateTime);
                else if (sport == 3) s3.push(bookings[i].startDateTime);
                else if (sport == 4) s4.push(bookings[i].startDateTime);
            }
        }
        s1.sort(function (a, b) {
            return new Date(b.date) - new Date(a.date);
        });
        s2.sort(function (a, b) {
            return new Date(b.date) - new Date(a.date);
        });
        s3.sort(function (a, b) {
            return new Date(b.date) - new Date(a.date);
        });
        s4.sort(function (a, b) {
            return new Date(b.date) - new Date(a.date);
        });
        s1.reverse();
        s2.reverse();
        s3.reverse();
        s4.reverse();
        return res.json({
            success: true,
            data: { s1, s2, s3, s4 },
            msg: 'Profile data received',
        });
    } catch (err) {
        console.log(`Error : ${err.message}`);
        res.status(500).json({ success: false, msg: 'Server Error' });
    }
});

module.exports = router;
