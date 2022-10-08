const express = require('express');
const router = express.Router();
const Facility = require('../models/Facility');

//test route
router.get('/', (req, res) => {
    return 'hello';
});

module.exports = router;
