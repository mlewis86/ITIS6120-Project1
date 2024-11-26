const express = require('express');
const Patient = require('../models/patientModel');
const authenticateToken = require('../middleware/authMiddleware');

const router = express.Router();

// Get all patients (accessible by doctors and admins)
router.get('/', authenticateToken, async (req, res) => {
  if (req.user.role !== 'admin' && req.user.role !== 'doctor') {
    return res.status(403).json({ message: 'Access denied' });
  }

  try {
    const patients = await Patient.find();
    res.json(patients);
  } catch (err) {
    res.status(500).json({ message: 'Error retrieving patients', error: err });
  }
});

// Add a new patient (for doctors/admins)
router.post('/', authenticateToken, async (req, res) => {
  if (req.user.role !== 'admin' && req.user.role !== 'doctor') {
    return res.status(403).json({ message: 'Access denied' });
  }

  const { name, age, condition, doctorAssigned, status } = req.body;

  try {
    const newPatient = new Patient({ name, age, condition, doctorAssigned, status });
    await newPatient.save();
    res.status(201).json({ message: 'Patient added successfully', patientId: newPatient._id });
  } catch (err) {
    res.status(500).json({ message: 'Error adding patient', error: err });
  }
});

module.exports = router;
