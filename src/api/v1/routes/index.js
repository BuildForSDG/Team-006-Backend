import express from 'express';

const router = express.Router();

// default response to base URL
router.get('/', (req, res) => {
  res.status(200).send('Team 006 Backend is up and running!');
});

export default router;