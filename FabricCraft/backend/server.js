const express = require('express');
const cors = require('cors');

// --- Route Imports ---
const authRoutes = require('./endpoints/auth');

// --- App Initialization ---
const app = express();
const PORT = process.env.PORT || 3000;

// --- Middleware ---
app.use(cors());
app.use(express.json());

// --- API Routes ---
app.use('/api/auth', authRoutes);

// --- Server Start ---
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
