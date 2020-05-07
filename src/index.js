import app from './app';

// Setup the app port
const port = process.env.PORT || 3000;
app.listen(port, () => {
  // eslint-disable-next-line no-console
  console.log('Node Server Started', `Listening at Port: ${port}`);
});

export default app;
