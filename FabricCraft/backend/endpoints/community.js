const express = require('express');
const router = express.Router();

// --- Community & Social Endpoints ---

// GET /api/community/feed
// Get the community feed posts.
router.get('/feed', (req, res) => {
  // TODO: Implement pagination and infinite scroll logic.
  // TODO: Fetch posts from the database, sorted by date or trendiness.
  res.json([
    { post_id: 101, creator: 'StyleStar123', likes: 1500, comments: [], is_trending: true },
    { post_id: 102, creator: 'DesignDiva', likes: 890, comments: [], is_trending: false },
    { post_id: 103, creator: 'FashionForward', likes: 2300, comments: [], is_trending: true }
  ]);
});

// POST /api/community/like
// Like a post.
router.post('/like', (req, res) => {
  const { post_id } = req.body;
  // TODO: Add authentication to know which user is liking the post.
  // TODO: Update the like count for the post in the database.
  console.log(`Post ${post_id} liked.`);
  res.json({ status: 'success', message: 'Post liked.' });
});

// POST /api/community/comment
// Comment on a post.
router.post('/comment', (req, res) => {
  const { post_id, comment_text } = req.body;
  // TODO: Add authentication.
  // TODO: Save the comment to the database, associated with the post.
  console.log(`New comment on post ${post_id}: ${comment_text}`);
  res.status(201).json({ status: 'success', message: 'Comment added.' });
});

// POST /api/community/follow
// Follow a user.
router.post('/follow', (req, res) => {
    const { user_id_to_follow } = req.body;
    // TODO: Add authentication to get the follower's ID.
    // TODO: Update the followers/following lists in the database.
    console.log(`User wants to follow ${user_id_to_follow}.`);
    res.json({ status: 'success', message: 'User followed.' });
});

module.exports = router;
