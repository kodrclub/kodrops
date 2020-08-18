const mongoose = require('mongoose');
const mongoUri = process.env.MONGO_URI;

mongoose
  .connect(
    mongoUri,
    { useNewUrlParser: true }
    //
  )
  .catch((e) => {
    console.error('Connection error', e.message);
  });

const db = mongoose.connection;

module.exports = db;
