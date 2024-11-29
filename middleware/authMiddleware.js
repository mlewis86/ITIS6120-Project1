const jwt = require('jsonwebtoken');
const User = require('../models/userModel');
const Doctor = require('../models/doctorModel');
const Patient = require('../models/patientModel');

// Middleware to verify token
const verifyToken = (req, res, next) => {
    const token = req.headers.authorization?.split(' ')[1];
    if (!token) return res.status(403).json({ message: 'Access denied. No token provided.' });

    try {
        const decoded = jwt.verify(token, 'your_jwt_secret');
        req.user = decoded;
        next();
    } catch (error) {
        res.status(401).json({ message: 'Invalid token.' });
    }
};

// Middleware to restrict routes based on roles
const authMiddleware = (allowedRoles = []) => async (req, res, next) => {
    try {
        const { userId, role } = req.user;

        // Fetch user from the appropriate collection
        let user;
        if (role === 'patient') user = await Patient.findById(userId);
        else if (role === 'doctor') user = await Doctor.findById(userId);
        else user = await User.findById(userId);

        if (!user || !allowedRoles.includes(role)) {
            return res.status(403).json({ message: 'Access denied. Insufficient permissions.' });
        }

        req.userDetails = user; // Attach user details to request
        next();
    } catch (error) {
        res.status(500).json({ message: 'Internal server error.' });
    }
};

module.exports = { verifyToken, authMiddleware };
