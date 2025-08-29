const express = require('express');
const router = express.Router();

// --- Admin Endpoints ---
// IMPORTANT: All routes in this file should be protected by an admin-only authentication middleware.

// GET /api/admin/dashboard
// Get analytics for the admin dashboard.
router.get('/dashboard', (req, res) => {
  // TODO: Fetch data from various collections (users, posts, sales) to build analytics.
  res.json({
    active_users: 1234,
    trending_designs: [
      { post_id: 103, name: 'Future Funk Jacket' },
      { post_id: 101, name: 'Cyberpunk Visor' }
    ],
    sales_today: 56,
    pending_approvals: 12
  });
});

// POST /api/admin/approve
// Approve a marketplace listing or user post.
router.post('/approve', (req, res) => {
  const { item_id, type } = req.body;
  // TODO: Update the status of the item in the database from 'pending' to 'approved'.
  console.log(`Approving ${type} with ID: ${item_id}`);
  res.json({ status: 'success', message: `${type} approved.` });
});

// POST /api/admin/set-fees
// Set fees for manufacturers.
router.post('/set-fees', (req, res) => {
  const { listing_fee, ai_training_fee } = req.body;
  // TODO: Save these fee structures in a config/database collection.
  console.log(`Setting fees: Listing=${listing_fee}, AI Training=${ai_training_fee}`);
  res.json({ status: 'success', message: 'Fees updated.' });
});

module.exports = router;
