const express = require('express');
const User = require('../models/userModel');
const authenticateToken = require('../middleware/authMiddleware');

const router = express.Router();

// Create a new user
router.post('/', authenticateToken, async (req, res) => {
  const { username, password, role } = req.body;

  if (req.user.role !== 'admin') {
    return res.status(403).json({ message: 'Access denied' });
  }

  try {
    const user = new User({ username, password, role });
    await user.save();

    res.status(201).json({ message: 'User created successfully', userId: user._id });
  } catch (err) {
    res.status(500).json({ message: 'Error creating user', error: err });
  }
});

module.exports = router;

