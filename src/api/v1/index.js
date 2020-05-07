import { Router } from 'express';
import cors from 'cors';
// Controllers import
import exampleController from './controllers/example';

// v1 Api Router
const v1app = Router();

// Use cors for cross origin request for api
v1app.use(cors());

v1app.get('/', (req, res) => {
  res.send('V1 app working');
});

v1app.get('/example', exampleController);
export default v1app;
