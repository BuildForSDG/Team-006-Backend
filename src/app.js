import express from 'express';
import bodyParser from 'body-parser';
import logger from 'morgan';

import api from './api/index';

// Initialize the Main express app
const app = express();

// use body parser so we can get info from POST and/or URL parameters
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

// setup the logger
app.use(logger('tiny'));

// Set up a test endpoint
app.get('/test-app', (req, res) => {
  res.send('App on point');
});

// Api Router
app.use('/api', api);

/**
 * 404 page
 */
app.use((req, res) => {
  res.status(404).send('Page not found');
});
export default app;
