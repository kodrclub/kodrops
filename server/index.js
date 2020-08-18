const app = require('./app').app;
const db = require('./db');

app.listen(apiPort, () => console.log(`Server running on port ${apiPort}`));
