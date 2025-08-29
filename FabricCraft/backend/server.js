const express = require('express');
const cors = require('cors');
require('dotenv').config();

// --- Route Imports ---
const aiRoutes = require('./endpoints/ai');
const marketplaceRoutes = require('./endpoints/marketplace');
const communityRoutes = require('./endpoints/community');
const adminRoutes = require('./endpoints/admin');
const socialRoutes = require('./endpoints/social');

// --- App Initialization ---
const app = express();
const PORT = process.env.PORT || 3000;

// --- Middleware ---
app.use(cors());
app.use(express.json());

// --- API Routes ---
app.get('/', (req, res) => {
  res.send('Fabric Craft Backend is running!');
});

app.use('/api/ai', aiRoutes);
app.use('/api/marketplace', marketplaceRoutes);
app.use('/api/community', communityRoutes);
app.use('/api/admin', adminRoutes);
app.use('/api/social', socialRoutes);

// --- Server Start ---
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
