const express = require('express');
const router = express.Router();
const Facility = require('../models/Facility');

router.get('/', (req, res) => {
    return 'hello';
});



module.exports = router;
