const express = require('express');
const router = express.Router();
const User = require('../models/User');

// Register a user
router.post('/register', async (req, res) => {
    const { firstName, lastName, email, contactNumber } = req.body;

    try {
        let user = await User.findOne({ email });

        if (user) {
            return res
                .status(400)
                .json({ success: false, msg: 'User already exists.' });
        }

        user = new User({
            firstName,
            lastName,
            email,
            contactNumber,
            isLoggedIn: false,
        });

        await user.save();
        res.json({ success: true, msg: 'registered' });
    } catch (err) {
        console.log(`Error : ${err.message}`);
        res.status(500).json({ success: false, msg: 'Server Error' });
    }
});

module.exports = router;
