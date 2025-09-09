const express = require('express');
const router = express.Router();

const products = [
  { id: 1, name: 'Classic T-Shirt', price: 19.99, image: 'res://assets/placeholder.png' },
  { id: 2, name: 'Denim Jeans', price: 49.99, image: 'res://assets/placeholder.png' },
  { id: 3, name: 'Running Shoes', price: 79.99, image: 'res://assets/placeholder.png' },
];

router.get('/products', (req, res) => {
  res.json(products);
});

module.exports = router;
