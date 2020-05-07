import express from 'express';
import logger from 'morgan';

const app = express();

// setup the logger
app.use(logger('tiny'));

// Set up a test endpoint
app.get('/test-app', (req, res) => {
  res.send('App on point');
});
export default app;
