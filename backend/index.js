require('./db');
const app = require('./app').app;
const apiPort = process.env.BACKEND_PORT || 3000;

const version = process.env.npm_package_version;
app.version = version;

app.listen(apiPort, () =>
  console.log(`Backend version ${version} running on port ${apiPort}`)
);
