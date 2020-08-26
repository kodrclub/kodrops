require('./db');
// const promMid = require('express-prometheus-middleware');

const app = require('./app').app;
// app.use(
//   promMid({
//     metricsPath: '/api/metrics',
//     // prefix: 'bcdop_backend_',
//     prefix: 'tlkk_',
//     collectDefaultMetrics: true,
//     requestDurationBuckets: [0.1, 0.5, 1, 1.5],
//   })
// );
const apiPort = process.env.BACKEND_PORT || 3000;

const version = process.env.npm_package_version;
app.version = version;

app.listen(apiPort, () =>
  console.log(`Backend version ${version} running on port ${apiPort}`)
);
