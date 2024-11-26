const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const cors = require('cors'); // Allow cross-origin requests
const authRoutes = require('./routes/auth'); // Import the authentication routes

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(bodyParser.json()); // To parse JSON request body
app.use(cors()); // Enable CORS for the frontend
app.use(express.static('client')); // Serve static files from client folder

// Database connection
mongoose.connect('mongodb://localhost/Emergency_Department', { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log('Connected to MongoDB'))
  .catch(err => console.error('Error connecting to MongoDB:', err));

// Routes
app.use('/auth', authRoutes); // Link the authentication routes

// Start the server
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
