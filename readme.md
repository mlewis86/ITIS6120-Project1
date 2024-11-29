├── server.js
├── db.js
├── routes/
│   ├── auth.js         <-- Authentication routes (signup, login)
├── middleware/
│   ├── authMiddleware.js <-- Middleware for authentication/authorization
├── models/
│   ├── userModel.js    <-- User schema
│   ├── patientModel.js <-- Patient schema
│   ├── doctorModel.js  <-- Doctor schemaa
├── client/
│   ├── login.html      <-- Main entry and Login page
│   ├── signup.html     <-- Signup page
│   ├── dashboard.html  <-- Shared dashboard
dashboard
│   ├── script.js       <-- Handles role-based redirection
