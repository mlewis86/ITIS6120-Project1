// routes/auth.js
const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { verifyToken, authMiddleware } = require('../middleware/authMiddleware');
const User = require('../models/userModel');
const Patient = require('../models/patientModel');
const Doctor = require('../models/doctorModel');

const router = express.Router();

// Signup route
router.post('/signup', async (req, res) => {
    try {
        const { username, email, password, role, medicalHistory, specialization, emergencyContact, experience } = req.body;

        if (!username || !email || !password || !role) {
            return res.status(400).json({ message: 'All fields are required.' });
        }

        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ message: 'User already exists.' });
        }

        const hashedPassword = await bcrypt.hash(password, 10);

        // Save user to appropriate collection
        let newUser;
        if (role === 'patient') {
            newUser = new Patient({
                username,
                email,
                password: hashedPassword,
                role,
                medicalHistory,
                emergencyContact,
            });
        } else if (role === 'doctor') {
            newUser = new Doctor({
                username,
                email,
                password: hashedPassword,
                role,
                specialization,
                experience,
            });
        } else {
            newUser = new User({
                username,
                email,
                password: hashedPassword,
                role,
            });
        }
        await newUser.save();

        res.status(201).json({ message: 'User registered successfully.' });
    } catch (error) {
        res.status(500).json({ message: 'Signup error.', error });
    }
});

// Login route
router.post('/login', async (req, res) => {
    try {
        const { email, password } = req.body;

        let user = await Patient.findOne({ email }) || 
                   await Doctor.findOne({ email }) || 
                   await User.findOne({ email });

        if (!user) return res.status(400).json({ message: 'Invalid credentials.' });

        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) return res.status(400).json({ message: 'Invalid credentials.' });

        const token = jwt.sign({ userId: user._id, role: user.role }, 'your_jwt_secret', { expiresIn: '1h' });

        res.status(200).json({ token, role: user.role });
    } catch (error) {
        res.status(500).json({ message: 'Login error.', error });
    }
});

// Protected route for role-based dashboards
router.get('/dashboard', verifyToken, authMiddleware(['patient', 'doctor', 'nurse', 'admin']), (req, res) => {
    const { role } = req.user;
    let message;

    if (role === 'patient') {
        message = 'Welcome to the Patient Dashboard.';
    } else if (role === 'doctor') {
        message = 'Welcome to the Doctor Dashboard.';
    } else if (role === 'nurse') {
        message = 'Welcome to the Nurse Dashboard.';
    } else {
        message = 'Welcome to the Admin Dashboard.';
    }

    res.status(200).json({ message, userDetails: req.userDetails });
});

module.exports = router;
