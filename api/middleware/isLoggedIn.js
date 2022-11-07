const User = require('../models/User');

module.exports = async function (req, res, next) {
    console.log(req.body);
    try {
        const user = await User.findOne({ email: req.body.email });
        req.user = user;
        if (user) {
            next();
        }
    } catch (err) {
        res.status(401).json({
            success: false,
            msg: 'Email is not valid. Please log in again.',
        });
    }
};
