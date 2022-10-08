const express = require('express');
const router = express.Router();
const { check, validationResult } = require('express-validator');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const User = require('../models/User');
const isLoggedIn = require('../middleware/isLoggedIn');

//Get logged in user
router.get('/', isLoggedIn, async (req, res) => {
    try {
        const user = await User.findById(req.user.id).select('-password');
        res.json({
            success: true,
            msg: 'User found',
            data: {
                user: user,
            },
        });
    } catch (err) {
        console.log(`Error : ${err.message}`);
        res.status(500).json({ success: false, msg: 'Server Error.' });
    }
});

//Auth user and get token
router.post(
    '/',
    [
        check('email', 'Please enter a valid email address.').isEmail(),
        check('password', 'Incorrect Password').isLength({ min: 8 }),
    ],
    async (req, res) => {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res
                .status(400)
                .json({ success: false, errors: errors.array() });
        }

        const { email, password } = req.body;

        try {
            let user = await User.findOne({ email });
            if (!user) {
                return res
                    .status(400)
                    .json({ success: false, msg: 'User is not registered.' });
            }
            const isMatch = await bcrypt.compare(password, user.password);

            if (!isMatch) {
                return res
                    .status(400)
                    .json({ success: false, msg: 'Incorrect Password' });
            }

            const payload = {
                user: {
                    id: user.id,
                },
            };

            const token = jwt.sign(payload, process.env.JWT_SECRET, {
                expiresIn: '720h',
            });

            res.json({
                success: true,
                msg: 'User successfully logged in!',
                data: {
                    token: token,
                },
            });
        } catch (err) {
            console.log(`Error : ${err.message}`);
            res.status(500).json({ success: false, msg: 'Server Error' });
        }
    }
);

// Register a user
router.post(
    '/register',
    [
        check('name', 'Please enter a name.').not().isEmpty(),
        check('email', 'Please enter a valid email address.').isEmail(),
        check(
            'password',
            'Please enter a password with 8 or more characters.'
        ).isLength({ min: 8 }),
        check(
            'password',
            "Password can't contain more than 30 characters."
        ).isLength({ max: 30 }),
        check('regno', 'Please enter your registration number.')
            .not()
            .isEmpty(),
        check('username', 'Please enter a username.').not().isEmpty(),
        check('college', 'Please enter a college name.').not().isEmpty(),
        check('phoneNo', 'Please enter you phone number').not().isEmpty(),
        check(
            'username',
            "Username can't contain more than 30 characters."
        ).isLength({ max: 30 }),
        check('name', "Name can't contain more than 30 characters.").isLength({
            max: 30,
        }),
        check(
            'email',
            "Email can't contain more than 500 characters."
        ).isLength({ max: 500 }),
    ],
    async (req, res) => {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res
                .status(400)
                .json({ success: false, msg: errors.array()[0].msg });
        }

        const { name, email, password, regno, username, college, phoneNo } =
            req.body;

        try {
            let user = await User.findOne({ email });

            if (user) {
                return res
                    .status(400)
                    .json({ success: false, msg: 'User already exists.' });
            }

            user = await User.findOne({ username });

            if (user) {
                return res.status(400).json({
                    success: false,
                    msg: 'Please choose a different username.',
                });
            }
            const salt = await bcrypt.genSalt(10);
            const hashpassword = await bcrypt.hash(password, salt);
            user = new User({
                name,
                email,
                password: hashpassword,
                regno,
                username,
                college,
                phoneNo,
            });

            await user.save();
            res.json({ success: true, msg: 'registered' });
        } catch (err) {
            console.log(`Error : ${err.message}`);
            res.status(500).json({ success: false, msg: 'Server Error' });
        }
    }
);

module.exports = router;
