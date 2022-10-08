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

        let booked = 0;
        for (let i = 0; i < bookings.length; i++) {
            if (
                (chosenStartDate >= bookings[i].startdate &&
                    chosenStartDate <= bookings[i].enddate) ||
                (chosenEndDate >= bookings[i].startdate &&
                    chosenEndDate <= bookings[i].enddate)
            ) {
                booked++;
                break;
            }
        }
        if (booked == facility.count) {
            res.json({
                success: true,
                msg: 'cannot book as all are occupied',
            });
        } else {
            //allow booking
            const newBooking = new Booking({
                startdate: chosenStartDate,
                enddate: chosenEndDate,
                user: req.user._id,
                facility: chosenFacility,
            });
            facility.count += 1;
            await facility.save();
            await newBooking.save();
            res.json({
                success: true,
                msg: 'booked successfully.',
            });
        }
    } catch (err) {
        console.log(`Error : ${err.message}`);
        res.status(500).json({ success: false, msg: 'Server Error' });
    }
});

//edit booking

//cancel booking

module.exports = router;
