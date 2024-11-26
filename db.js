// db.js
const mysql = require('mysql2');
const mongoose = require('mongoose');

// MySQL Connection
const mysqlConnection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '2627Hb##',
  database: 'Emergency_Department',
  port: 3306
});


// MongoDB Connection for User Authentication
mongoose.connect('mongodb://localhost:27017/userAuthentication')
    .then(() => {
        console.log('MongoDB connected for user authentication.');
    })
    .catch(err => {
        console.error('Error connecting to MongoDB:', err);
    });

module.exports = { mysqlConnection, mongoose };
