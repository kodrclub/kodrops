const express = require('express');
const app = express();
const port = process.env.HELLO_PORT || 3000;

app.get('/hello', (req, res) => {
  res.send(`
    <h1>Hello, World!</h1>
    <img src="https://placekitten.com/300/200"></img>
    `);
});

app.get('/', (req, res) => {
  res.send(`
    <img src="https://placekitten.com/300/200"></img>
    <h1>You should not see me</h1>
  `);
});

app.listen(port, () => console.log(`Example app listening on port ${port}!`));
