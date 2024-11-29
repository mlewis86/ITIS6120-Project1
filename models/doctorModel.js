const mongoose = require('mongoose');

const doctorSchema = new mongoose.Schema({
    username: { type: String, required: true, unique: true },
    email: { type: String, required: true, unique: true },
    password: { type: String, required: true },
    role: { type: String, default: 'doctor', immutable: true },
    specialization: { type: String, required: true },
    experience: { type: Number, required: true },
    patients: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Patient' }]
});


const Doctor = mongoose.model('Doctor', doctorSchema);

module.exports = Doctor;
