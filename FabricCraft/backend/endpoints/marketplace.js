const express = require('express');
const router = express.Router();

const products = [
  { "name": "Classic T-Shirt", "price": 19.99 },
  { "name": "Denim Jeans", "price": 49.99 },
  { "name": "Running Shoes", "price": 79.99 },
  { "name": "Leather Jacket", "price": 149.99 },
];

// GET /api/marketplace/products
router.get('/products', (req, res) => {
  res.json(products);
});

module.exports = router;
