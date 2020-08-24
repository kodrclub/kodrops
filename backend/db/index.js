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

db.on('connecting', function () {
  console.log('connecting to MongoDB...');
});

db.on('error', function (error) {
  console.error('Error in MongoDb connection: ' + error);
  mongoose.disconnect();
});
db.on('connected', function () {
  console.log('MongoDB connected!');
});
db.once('open', function () {
  console.log('MongoDB connection opened!');
});
db.on('reconnected', function () {
  console.log('MongoDB reconnected!');
});
db.on('disconnected', function () {
  console.log('MongoDB disconnected!');
  mongoose.connect(mongoUri, { server: { auto_reconnect: true } });
});
mongoose.connect(mongoUri, { server: { auto_reconnect: true } });

module.exports = db;
