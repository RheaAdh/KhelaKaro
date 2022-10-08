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

const PORT = process.env.PORT || 5000;

app.listen(PORT, () => console.log(`Server started on port ${PORT}.`));
