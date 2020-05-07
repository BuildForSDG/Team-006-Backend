import express from 'express';
import v1app from './v1/index';

const api = express();

/**
 * Api vsersion 1
 */

api.use('/v1', v1app);

// Not found Endpoints
api.use((req, res) => {
  res.status(404).send({
    message: 'Endpoint Not Found',
    data: {}
  });
});

export default api;
