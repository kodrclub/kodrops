const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const movieRouter = require('./routes/movie-router');

const app = express();

app.use(bodyParser.urlencoded({ extended: true }));
app.use(cors());
app.use(bodyParser.json());

app.get('/api/version', (req, res) => {
  res.send(JSON.stringify({ version: app.version }));
});

app.use('/api', movieRouter);

app.get('/', (req, res) => {
  res.send('You should not see me');
});

module.exports.app = app;
