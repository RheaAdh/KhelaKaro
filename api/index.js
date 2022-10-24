const express = require('express');
const dotenv = require('dotenv');
const connectDB = require('./config/db');
const app = express();

// Load Config
dotenv.config({ path: './.env' });

// Connect Database
connectDB();

// Init middleware
app.use(express.json({ extended: false }));

// Routes
app.use('/api', require('./routes/index'));
app.use('/api/booking', require('./routes/booking'));
app.use('/api/facility', require('./routes/facility'));
app.use('/api/stats', require('./routes/stats'));
app.use('/api/auth', require('./routes/auth'));

const PORT = process.env.PORT || 5001;

app.listen(PORT, () => console.log(`Server started on port ${PORT}.`));
