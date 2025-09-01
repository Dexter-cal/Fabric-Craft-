const express = require('express');
const router = express.Router();

// In-memory array to act as a temporary user database.
const users = [];

// POST /api/auth/register
router.post('/register', (req, res) => {
  const { email, password, username } = req.body;

  if (!email || !password || !username) {
    return res.status(400).json({ message: 'Please provide email, password, and username.' });
  }

  const existingUser = users.find(user => user.email === email);
  if (existingUser) {
    return res.status(409).json({ message: 'User with this email already exists.' });
  }

  // NOTE: In a real app, NEVER store plain text passwords. Always hash them.
  let role = "user";
  if (email === "admin@fabric.craft") {
    role = "admin";
  }

  const newUser = { id: users.length + 1, username, email, password, role };
  users.push(newUser);

  console.log('User registered:', newUser);
  res.status(201).json({ message: 'User registered successfully.', userId: newUser.id });
});

// POST /api/auth/login
router.post('/login', (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return res.status(400).json({ message: 'Please provide email and password.' });
  }

  const user = users.find(user => user.email === email);

  if (!user || user.password !== password) {
    return res.status(401).json({ message: 'Invalid credentials.' });
  }

  console.log('User logged in:', user);
  res.status(200).json({
    message: 'Login successful.',
    userId: user.id,
    username: user.username,
    role: user.role // Return the user's role
  });
});

module.exports = router;
