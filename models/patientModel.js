const mongoose = require('mongoose');

const PatientSchema = new mongoose.Schema({
    username: { type: String, required: true },
    email: { type: String, required: true },
    password: { type: String, required: true },
    role: { type: String, required: true },
    medicalHistory: { type: String, required: true },
    emergencyContact: { type: String, required: true },
    status: { type: String, default: 'active' } 
});

// Use PatientSchema here
const Patient = mongoose.model('Patient', PatientSchema);

module.exports = Patient;
