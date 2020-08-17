const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const db = require('./db');
const movieRouter = require('./routes/movie-router');

const app = express();
const apiPort = 3000;

app.use(bodyParser.urlencoded({ extended: true }));
app.use(cors());
app.use(bodyParser.json());

db.on('error', console.error.bind(console, 'MongoDB connection error:'));

app.get('/', (req, res) => {
  console.log('===============================');
  console.log('HELLO');
  console.log('===================');
  res.send('Hello World!');
});
app.get('/server', (req, res) => {
  console.log('===============================');
  console.log('SERVER');
  console.log('===================');
  res.send('Hello server!');
});
// app.get('/api', (req, res) => {
//   console.log('===============================');
//   console.log('API');
//   console.log('===================');
//   res.send('Hello API!');
// });
app.use('/api', movieRouter);

app.listen(apiPort, () => console.log(`Server running on port ${apiPort}`));
