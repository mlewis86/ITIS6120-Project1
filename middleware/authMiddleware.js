// middleware/authMiddleware.js
const jwt = require('jsonwebtoken');
const User = require('../models/userModel');


// Middleware to check if the user is authenticated
const authenticateToken = (req, res, next) => {
  const token = req.header('Authorization')?.replace('Bearer ', '');
  
  if (!token) return res.status(401).json({ message: 'Access denied' });

  jwt.verify(token, 'your_jwt_secret', async (err, user) => {
    if (err) return res.status(403).json({ message: 'Invalid token' });
    
    const foundUser = await User.findById(user._id);
    if (!foundUser) return res.status(404).json({ message: 'User not found' });

    req.user = foundUser;
    next();
  });
};

module.exports = authenticateToken;
