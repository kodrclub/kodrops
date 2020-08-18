const request = require('supertest');
const app = require('../../app').app;
const mongoose = require('mongoose');

it('passes', async () => {
  expect(2 + 3).toEqual(5);
});

it('returns a 404 if the movie is not found', async () => {
  const id = global.generateId();

  const r = await request(app)
    .get(`/api/movies/${id}`) //BEWARE!!! make sure to use a valid ObjectId. Just passing a random string as an id will result in a 500 error!
    .send()
    .expect(404);
});
