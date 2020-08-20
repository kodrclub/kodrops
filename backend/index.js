require('./db');
const app = require('./app').app;
const apiPort = process.env.BACKEND_PORT || 3000;

app.listen(apiPort, () => console.log(`Backend running on port ${apiPort}`));
