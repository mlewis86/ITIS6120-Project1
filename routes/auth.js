// routes/auth.js
const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

const User = require('../models/userModel'); // Import user model

const router = express.Router();

// POST /signup - User signup route
router.post('/signup', async (req, res) => {
    try {
        const { username, email, password, role } = req.body;
        // Validate fields
        if (!username || !email || !password) {
            return res.status(400).json({ msg: 'All fields are required' });
        }

        // Check if the user already exists (by email or username)
        const existingUser = await User.findOne({ $or: [{ username }, { email }] });
        if (existingUser) {
            return res.status(400).json({
                error: existingUser.username === username 
                    ? `The username "${username}" is already taken.` 
                    : `The email "${email}" is already registered.`
            });
        }
        // Hash the password
        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password, salt);

        // Create a new user
        const newUser = new User({ 
            username, 
            email, 
            password : hashedPassword, 
            role 
        });

        // Save the user to the database
        const savedUser = await newUser.save();
        res.status(201).json({ message: 'User registered successfully!' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'An error occurred during signup.' });
    }
});

// POST /login - User login route
router.post('/login', async (req, res) => {
    const { username, password } = req.body;

    try {
        // Find the user by username or email
        const user = await User.findOne({ $or: [{ username }, { email: username }] });
        if (!user) {
            return res.status(400).json({ error: 'Invalid credentials' });
        }

        // Compare password with hashed password
        const isMatch = await user.comparePassword(password);
        if (!isMatch) {
            return res.status(400).json({ error: 'Invalid credentials' });
        }

        // Generate JWT token
        const token = jwt.sign({ userId: user._id, role: user.role }, 'your_jwt_secret', { expiresIn: '1h' });
        
        res.json({ token });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'An error occurred during login.' });
    }
});

router.get('/test', async (req, res) => {
    try {
        const user = new User({
            username: 'TestUser',
            email: 'test@example.com',
            password: 'password123',
        });
        const savedUser = await user.save();
        res.json(savedUser);
    } catch (error) {
        console.error('Test route error:', error.message);
        res.status(500).json({ msg: 'Test failed' });
    }
});

module.exports = router;
