const mongoose = require('mongoose');
const mongoUri = process.env.MONGO_URI;
console.log('------------------------------------');
console.log(mongoUri);
console.log('----------------------------');
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
