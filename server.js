const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const cors = require('cors');
const path = require('path');
const User = require('./models/userModel');
const Doctor = require('./models/doctorModel');
const Patient = require('./models/patientModel');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { verifyToken, authMiddleware } = require('./middleware/authMiddleware');
const router = express.Router();
const authRoutes = require('./routes/auth');
const { connectDB } = require('./db');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(bodyParser.json());
app.use(cors());
app.use(express.static('client'));
app.use(express.json());

// Connect to the database
connectDB();

// Routes
app.use('/auth', authRoutes);

// Serve login.html as default page
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'client', 'login.html'));
});

// Start the server
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
