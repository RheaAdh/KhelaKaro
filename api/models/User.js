const mongoose = require('mongoose');
const UserSchema = mongoose.Schema({
    firstName: {
        type: String,
        required: true,
    },
    lastName: {
        type: String,
        required: true,
    },
    email: {
        type: String,
        required: true,
        unique: true,
    },
    contactNumber: {
        type: String,
        //required: true
    },
});
module.exports = mongoose.model('user', UserSchema);
