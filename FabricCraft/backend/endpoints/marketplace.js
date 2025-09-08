const express = require('express');
const router = express.Router();

const products = [
  {
    id: 1,
    name: 'Classic T-Shirt',
    price: 19.99,
    image: 'res://assets/placeholder.png',
    description: 'A comfortable and stylish 100% cotton t-shirt.'
  },
  {
    id: 2,
    name: 'Denim Jeans',
    price: 49.99,
    image: 'res://assets/placeholder.png',
    description: 'High-quality denim jeans with a modern fit.'
  },
  {
    id: 3,
    name: 'Running Shoes',
    price: 79.99,
    image: 'res://assets/placeholder.png',
    description: 'Lightweight and breathable running shoes.'
  },
];

router.get('/products', (req, res) => {
  res.json(products);
});

module.exports = router;
