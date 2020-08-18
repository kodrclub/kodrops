const request = require('supertest');
const app = require('../../app').app;
const Movie = require('../../models/movie-model');

// it('passes', async () => {
//   expect(2 + 3).toEqual(5);
// });

it('returns a 404 at `movie show` the endpoint if the movie is not found', async () => {
  const id = global.generateId();

  const r = await request(app)
    .get(`/movie/${id}`) //BEWARE!!! make sure to use a valid ObjectId. Just passing a random string as an id will result in a 500 error!
    .send()
    .expect(404);
});

it('returns the movie at the `movie show` endpoint if the movie exists', async () => {
  const name = 'Some title';
  const rating = 3;
  const _id = global.generateId();
  const movie = new Movie({
    _id,
    name,
    rating,
  });
  await movie.save();

  const response = await request(app)
    .get(`/api/movie/${_id}`)
    .send()
    .expect(200);

  expect(response.body.data.name).toEqual(name);
  expect(response.body.data.rating).toEqual(rating);
});

it('returns all the movies at the `movies index` endpoint', async () => {
  const count = 5;
  for (let i = 0; i < count; i++) {
    const movie = new Movie({
      name: 'dasdasdasdasd',
      rating: 1,
    });
    await movie.save();
  }

  const response = await request(app).get(`/api/movies`).send().expect(200);

  expect(response.body.data.length).toEqual(count);
});

it.todo('has a functioning create endpoint');
it.todo('has a functioning update endpoint');
it.todo('has a functioning delete endpoint');
