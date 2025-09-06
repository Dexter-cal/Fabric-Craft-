const express = require('express');
const router = express.Router();

// Placeholder product data
const products = [
  { id: 1, name: 'Classic T-Shirt', price: 19.99, image: 'res://assets/products/tshirt.png' },
  { id: 2, name: 'Denim Jeans', price: 49.99, image: 'res://assets/products/jeans.png' },
  { id: 3, name: 'Running Shoes', price: 79.99, image: 'res://assets/products/shoes.png' },
  { id: 4, name: 'Leather Jacket', price: 149.99, image: 'res://assets/products/jacket.png' },
  { id: 5, name: 'Beanie Hat', price: 14.99, image: 'res://assets/products/hat.png' },
];

// GET /api/marketplace/products
router.get('/products', (req, res) => {
  res.json(products);
});

module.exports = router;
