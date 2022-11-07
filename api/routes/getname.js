const express = require('express');
const User = require('../models/User');
const router = express.Router();

router.post('/', async (req, res) => {
    try {
        const user = await User.findOne({ email: req.body.email });
        req.user = user;
        if (user) {
            const firstName = user.firstName
            const lastName = user.lastName
            return res.send({
                success: true,
                msg: `${firstName} ${lastName}`
            });
        }
    } catch (err) {
        console.log(`Error : ${err.message}`);
        res.status(500).json({ success: false, msg: 'Server Error' });
    }
});

module.exports = router;