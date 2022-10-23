const express = require('express');
const isLoggedIn = require('../middleware/isLoggedIn');
const Booking = require('../models/Booking');
const Facility = require('../models/Facility');
const router = express.Router();

//book now
router.post('/:id', isLoggedIn, async (req, res) => {
    //if already booked for that time slot and facility we dont allow
    const chosenFacility = req.params.id;
    const chosenStartDate = req.body.startdate;
    const chosenEndDate = req.body.enddate;
    try {
        const facility = await Facility.findById(chosenFacility);
        const bookings = await Booking.find({
            facility: chosenFacility,
        });
        let countOfCourtsBooked = 0;
        var occupied = new Set();
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
        if (countOfCourtsBooked == facility.count) {
            res.json({
                success: true,
                msg: 'Cannot book as all are occupied',
            });
        } else {
            let bookCourtNumber = 0;
            for (let i = 1; i <= facility.count; i++) {
                if (occupied.find(i) != occupied.end()) {
                    bookCourtNumber = i;
                    break;
                }
            }
            //allow booking
            const newBooking = new Booking({
                startDateTime: start,
                endDateTime: end,
                user: req.user._id,
                facility: chosenFacility,
                courtNumber: bookCourtNumber,
            });

            await newBooking.save();
            res.json({
                success: true,
                msg: 'Booked successfully.',
            });
        }
    } catch (err) {
        console.log(`Error : ${err.message}`);
        res.status(500).json({ success: false, msg: 'Server Error' });
    }
});

module.exports = router;
