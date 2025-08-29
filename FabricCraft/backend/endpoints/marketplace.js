const express = require('express');
const router = express.Router();

// --- Marketplace Endpoints ---

// GET /api/marketplace/products
// Get a list of products with optional filters.
router.get('/products', (req, res) => {
  const { category, type, sortBy } = req.query;
  // TODO: Implement database query to fetch products.
  // Filter based on query parameters (category, type, etc.).
  // Sort based on sortBy parameter (popularity, newest).
  console.log(`Fetching products with filters: ${JSON.stringify(req.query)}`);
  res.json([
    { id: 1, name: 'Digital Bomber Jacket', price: 500, type: 'digital' },
    { id: 2, name: 'Real-life T-Shirt', price: 25.99, type: 'real' },
    { id: 3, name: 'DIY Sewing Kit', price: 40.00, type: 'real' }
  ]);
});

// POST /api/marketplace/list
// Add a new product to the marketplace (for manufacturers).
router.post('/list', (req, res) => {
  const { name, price, type, description } = req.body;
  // TODO: Add authentication to ensure only manufacturers can post.
  // TODO: Save the new product to the database.
  console.log(`New product listing: ${name}`);
  res.status(201).json({ status: 'success', message: 'Product listed for approval.' });
});

module.exports = router;
