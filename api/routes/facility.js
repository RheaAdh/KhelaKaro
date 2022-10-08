const express = require('express');
const router = express.Router();

//hardcode using this in DB for Marena
router.post('/add', async (req, res) => {
    const facility = new Facility({
        name: req.body.name,
        count: req.body.count,
    });
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
