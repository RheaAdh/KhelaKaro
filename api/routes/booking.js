const express = require('express');
const Booking = require('../models/Booking');
const Facility = require('../models/Facility');
const router = express.Router();

//Book a facility
router.post('/', async (req, res) => {
    const chosenFacility = req.body.facilityId;
    const newDate = new Date(req.body.startDateTime);
    const chosenStartDate = newDate.getTime();
    const chosenEndDate = chosenStartDate + 60 * 60;

    try {
        // const hourlySecond = chosenStartDate % 86400;
        // console.log(hourlySecond);
        //39600 is 11AM
        //64800 is 6PM
        // if (hourlySecond < 39600 || hourlySecond > 64800) {
        //     return res.send({
        //         success: false,
        //         msg: 'Please try to book start Time between working hours 11AM to 6PM',
        //     });
        // }

        //check if same person has already booked another facility for same startdatetime
        const currBookings = await Booking.find({ user: req.user._id });
        for (let i = 0; i < currBookings.length; i++) {
            const date = new Date(currBookings[i].startDateTime);
            if (chosenStartDate >= date && chosenStartDate <= date + 3600) {
                return res.send({
                    success: false,
                    msg: 'You have a clashing booking.',
                });
            }
        }

        const facility = await Facility.findOne({
            facilityId: chosenFacility,
        });
        const bookings = await Booking.find({
            facility: chosenFacility._id,
        });
        let alreadyBookedBooking = await Booking.findOne({
            startDateTime: chosenStartDate,
            user: req.user._id,
        });
        if (alreadyBookedBooking) {
            return res.send({
                success: false,
                msg: 'Already Booked for same time slot by you please try for another time slot after a gap of 24 hours.',
            });
        }
        // console.log('====================================');
        // console.log(chosenFacility._id);
        // console.log('====================================');
        // console.log('====================================');
        // const minDate = new Date((chosenStartDate - 12 * 60 * 60) * 1000);
        // const maxDate = new Date((chosenStartDate + 12 * 60 * 60) * 1000);
        // console.log(minDate, maxDate);
        // console.log('====================================');
        // let alreadyBookedWithinInterval = await Booking.find({
        //     startDateTime: {
        //         $gt: minDate,
        //         $lt: maxDate,
        //     },
        //     user: req.user._id,
        //     facility: chosenFacility._id,
        // });
        let arr = await Booking.find({
            user: req.user._id,
            facility: facility._id,
        });
        for (let i = 0; i < arr.length; i++) {
            const minDate = new Date(arr[i].startDateTime) - 86400;
            const sBetweenDates = Math.abs(minDate - chosenStartDate);
            const hoursBetweenDates = sBetweenDates / (60 * 60 * 1000);
            console.log('====================================');
            console.log(hoursBetweenDates);
            console.log('====================================');
            if (hoursBetweenDates < 24) {
                return res.send({
                    success: false,
                    msg: 'You already have a booking within past 24hours for same sport.',
                });
            }
        }

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
                msg: 'Cannot book as all are occupied by others.',
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
                facility: facility._id,
                courtNumber: bookCourtNumber,
            });

            await newBooking.save();
            res.json({
                success: true,
                courtNumber: bookCourtNumber,
                msg: 'Booked court ' + bookCourtNumber + ' successfully!',
            });
        }
    } catch (err) {
        console.log(`Error : ${err.message}`);
        res.status(500).json({ success: false, msg: 'Server Error' });
    }
});

module.exports = router;
