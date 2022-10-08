const express = require('express');
const router = express.Router();
const Facility = require('../models/Facility');

router.get('/', (req, res) => {
    return 'hello';
});

router.post('/add', async (req, res) => {
    const facility = new Facility({ name: req.body.name });
    try {
        await facility.save();
        res.json({
            success: true,
            msg: 'added successfully.',
        });
    } catch (err) {
        console.log(`Error : ${err.message}`);
        res.status(500).json({ success: false, msg: 'Server Error' });
    }
});

module.exports = router;
