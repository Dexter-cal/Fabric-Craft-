const express = require('express');
const router = express.Router();

const posts = [
  { id: 101, creator: 'StyleStar123', likes: 1502, image: 'res://assets/placeholder.png', caption: 'Loving this new design!' },
  { id: 102, creator: 'DesignDiva', likes: 894, image: 'res://assets/placeholder.png', caption: 'Just finished this pattern.' },
];

router.get('/feed', (req, res) => {
  res.json(posts);
});

module.exports = router;
