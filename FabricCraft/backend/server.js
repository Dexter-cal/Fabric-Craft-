const express = require('express');
const cors = require('cors');

const authRoutes = require('./endpoints/auth');
const marketplaceRoutes = require('./endpoints/marketplace');
const communityRoutes = require('./endpoints/community');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

app.use('/api/auth', authRoutes);
app.use('/api/marketplace', marketplaceRoutes);
app.use('/api/community', communityRoutes);

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
