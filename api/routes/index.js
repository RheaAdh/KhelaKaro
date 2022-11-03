const express = require('express');
const router = express.Router();

//test route
router.get('/', (req, res) => {
    return 'hello';
});

module.exports = router;
