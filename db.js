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
const connectDB = async () => {
        try {
            await mongoose.connect('mongodb://localhost:27017/userAuthentication', {
              
                useNewUrlParser: true,
                useUnifiedTopology: true,
            });
            console.log('Connected to MongoDB');
        } catch (error) {
            console.error('Error connecting to MongoDB:', error.message);
            process.exit(1);
        }
    };

module.exports = { mysqlConnection, mongoose, connectDB };
