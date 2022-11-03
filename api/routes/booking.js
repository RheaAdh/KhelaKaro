const express = require('express');
const isLoggedIn = require('../middleware/isLoggedIn');
const Booking = require('../models/Booking');
const Facility = require('../models/Facility');
const router = express.Router();

//book now
router.post('/', isLoggedIn, async (req, res) => {
    //if already booked for that time slot and facility we dont allow

    const chosenFacility = req.body.facilityId;
    const chosenStartDate = req.body.startDateTime;
    const chosenEndDate = chosenStartDate + 60 * 60; //calculate +1hr dont take input
    try {
        const facility = await Facility.findOne({ facilityId: chosenFacility });
        const bookings = await Booking.find({
            facility: chosenFacility._id,
        });

        let countOfCourtsBooked = 0;
        var occupied = new Set();
        console.log('LENNNNN ');
        console.log(bookings.length);
        for (let i = 0; i < bookings.length; i++) {
            let start = bookings[i].startDateTime;
            let end = bookings[i].endDateTime;
            if (!(chosenStartDate >= end || chosenEndDate <= start)) {
                countOfCourtsBooked++;
                occupied.add(bookings[i].courtNumber);
                if (countOfCourtsBooked == facility.count) {
                    break;
                }
            }
        }
        console.log('countOfCourtsBooked', countOfCourtsBooked);
        console.log('facility.count', facility.count);
        if (countOfCourtsBooked == facility.count) {
            res.json({
                success: true,
                msg: 'Cannot book as all are occupied',
            });
        } else {
            let bookCourtNumber = 1;
            for (let i = 1; i <= facility.count; i++) {
                if (!occupied.has(i)) {
                    bookCourtNumber = i;
                    break;
                }
            }
            //allow booking
            const newBooking = new Booking({
                startDateTime: chosenStartDate,
                endDateTime: chosenEndDate,
                user: req.user._id,
                facility: chosenFacility._id,
                courtNumber: bookCourtNumber,
            });

            await newBooking.save();
            res.json({
                success: true,
                msg: 'Booked court ' + bookCourtNumber + ' successfully!',
            });
        }
    } catch (err) {
        console.log(`Error : ${err.message}`);
        res.status(500).json({ success: false, msg: 'Server Error' });
    }
});

module.exports = router;
