const mongoose = require('mongoose');
const fs = require('fs');
const User = require('./models/userModel');

// Connect to MongoDB
mongoose.connect('mongodb://localhost:27017/emergency_department', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

fs.readFile('users.json', 'utf8', async (err, data) => {
  if (err) throw err;
  const users = JSON.parse(data);

  for (const user of users) {
    const newUser = new User({
      username: user.username,
      password: user.password,
      role: user.role,
    });
    await newUser.save();
  }

  console.log('Users migrated successfully');
  mongoose.disconnect();
});
