const express = require('express');
const router = express.Router();

// In-memory database for placeholder purposes
const users = [];

// --- Authentication Endpoints ---

// POST /api/auth/register
// Register a new user.
router.post('/register', (req, res) => {
  const { email, password, username } = req.body;

  if (!email || !password || !username) {
    return res.status(400).json({ message: 'Please provide email, password, and username.' });
  }

  // Check if user already exists
  const existingUser = users.find(user => user.email === email);
  if (existingUser) {
    return res.status(409).json({ message: 'User with this email already exists.' });
  }

  // "Create" the new user (in a real app, hash the password!)
  const newUser = { id: users.length + 1, username, email, password };
  users.push(newUser);

  console.log('User registered:', newUser);
  console.log('Current users:', users);

  // In a real app, you'd return a token (e.g., JWT)
  res.status(201).json({ message: 'User registered successfully.', userId: newUser.id });
});

// POST /api/auth/login
// Log in an existing user.
router.post('/login', (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return res.status(400).json({ message: 'Please provide email and password.' });
  }

  // Find the user
  const user = users.find(user => user.email === email);

  // Check password (in a real app, compare hashed passwords!)
  if (!user || user.password !== password) {
    return res.status(401).json({ message: 'Invalid credentials.' });
  }

  console.log('User logged in:', user);

  // In a real app, you'd return a token (e.g., JWT)
  res.status(200).json({ message: 'Login successful.', userId: user.id, username: user.username });
});

module.exports = router;
