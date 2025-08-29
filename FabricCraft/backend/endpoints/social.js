const express = require('express');
const router = express.Router();

// --- Gamification & Social Rewards Endpoints ---

// GET /api/social/rewards
// Get a user's points, coins, and badges.
router.get('/rewards', (req, res) => {
  const { user_id } = req.query; // In a real app, this would come from an auth token
  // TODO: Fetch this user's gamification data from the database.
  res.json({
    user_id: user_id || 'guest',
    points: 5800,
    coins: 1250,
    badges: ['Top Creator', 'Trendsetter']
  });
});

// GET /api/social/leaderboard
// Get the weekly leaderboard.
router.get('/leaderboard', (req, res) => {
  // TODO: Aggregate data to find top users based on likes, followers, etc.
  res.json([
    { rank: 1, user: 'FashionForward', points: 12500 },
    { rank: 2, user: 'StyleStar123', points: 11800 },
    { rank: 3, user: 'DesignDiva', points: 10500 }
  ]);
});

// POST /api/social/claim-reward
// Claim a daily login bonus or challenge reward.
router.post('/claim-reward', (req, res) => {
    const { reward_id } = req.body;
    // TODO: Add authentication and logic to verify the reward is claimable.
    // TODO: Update the user's coin/point balance in the database.
    console.log(`User is claiming reward: ${reward_id}`);
    res.json({ status: 'success', message: 'Reward claimed!', new_coins: 1260 });
});

module.exports = router;
