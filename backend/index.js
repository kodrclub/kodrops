require('./db');
const app = require('./app').app;
const apiPort = 3000;

app.listen(apiPort, () => console.log(`Backend running on port ${apiPort}`));
