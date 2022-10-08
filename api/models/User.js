const mongoose = require('mongoose');
const crypto = require('crypto');
const bcrypt = require('bcrypt');

const UserSchema = mongoose.Schema({
    name: {
        type: String,
        required: true,
    },
    email: {
        type: String,
        required: true,
        unique: true,
    },
    password: {
        type: String,
        required: true,
    },
    regno: {
        type: String,
        required: true,
    },
    username: {
        type: String,
        required: true,
        unique: true,
    },
    college: {
        type: String,
        required: true,
    },
    phoneNo: {
        type: String,
        //required: true
    },
});
module.exports = mongoose.model('user', UserSchema);
