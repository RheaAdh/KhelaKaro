const express = require('express');
const router = express.Router();
const Facility = require('../models/Facility');

//hardcode using this in DB for Marena http://localhost:5000/api/facility/add
router.post('/add', async (req, res) => {
    try {
        const facility = new Facility({
            facilityId: req.body.facilityId,
            name: req.body.name,
            count: req.body.count,
        });
        await facility.save();
        res.json({
            success: true,
            msg: 'Added successfully.',
        });
    } catch (err) {
        console.log(`Error : ${err.message}`);
        res.status(500).json({ success: false, msg: 'Server Error' });
    }
});

router.post('/allfacilities', async (req, res) => {
    try {
        let facilities = await Facility.find();
        return res.json(facilities);
    } catch (err) {
        console.log(`Error : ${err.message}`);
        res.status(500).json({ success: false, msg: 'Server Error' });
    }
});
module.exports = router;
