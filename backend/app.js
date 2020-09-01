const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const prometheus = require('express-prometheus-middleware');

const movieRouter = require('./routes/movie-router');

const app = express();

//
// middlewares
//
app.use(bodyParser.urlencoded({ extended: true }));
app.use(cors());
app.use(bodyParser.json());
app.use(
  prometheus({
    metricsPath: '/api/metrics',
    // prefix: 'kodrops_backend_',
    prefix: 'kodrops_',
    collectDefaultMetrics: true,
    requestDurationBuckets: [0.1, 0.5, 1, 1.5],
  })
);

//
// routes
//
app.get('/api/version', (req, res) => {
  res.send(JSON.stringify({ version: app.version }));
});

app.use('/api', movieRouter);

app.get('/', (req, res) => {
  res.send('You should not see me');
});

module.exports.app = app;
