const express = require('express');
const router = express.Router();

const users = [];

router.post('/register', (req, res) => {
  const { email, password, username } = req.body;
  if (!email || !password || !username) {
    return res.status(400).json({ message: 'Please provide all fields.' });
  }
  if (users.find(user => user.email === email)) {
    return res.status(409).json({ message: 'User already exists.' });
  }
  const newUser = { id: users.length + 1, username, email, password, role: 'user' };
  users.push(newUser);
  console.log('User registered:', newUser);
  res.status(201).json({ message: 'User registered successfully.', userId: newUser.id });
});

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
  res.status(200).json({ message: 'Login successful.', userId: user.id, username: user.username, role: user.role });
});

module.exports = router;
