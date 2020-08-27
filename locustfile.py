import random, time
from locust import HttpUser, task, between

class QuickstartUser(HttpUser):
    wait_time = between(1, 2)

    @task
    def index_page(self):
        for count in range(50):
            self.client.get("/api/movies")
            time.sleep(2)

    @task(3)
    def create_movie(self):
        ident = str(random.randint(1,1000))
        for count in range(100):
            self.client.post("/api/movie", {"name": "locust_%s_%s" % (ident, count),  "rating": random.randint(1,9)})
            time.sleep(1)

    @task(3)
    def create_movie_fail(self):
        self.client.post("/api/movie", {})
        time.sleep(1)
