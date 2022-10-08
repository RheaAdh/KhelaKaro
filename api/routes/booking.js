const express = require('express');
const isLoggedIn = require('../middleware/isLoggedIn');
const Booking = require('../models/Booking');
const Facility = require('../models/Facility');
const router = express.Router();

//book now
router.post('/', isLoggedIn, async (req, res) => {
    //if already booked for that time slot and facility we dont allow
    const chosenFacility = req.body.facility;
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
                msg: 'cant book',
            });
        } else {
            //allow booking
            const newBooking = new Booking({
                startdate: chosenStartDate,
                enddate: chosenEndDate,
                user: req.user,
                facility: chosenFacility,
            });
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
