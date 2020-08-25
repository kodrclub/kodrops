import random, time
from locust import HttpUser, task, between

class QuickstartUser(HttpUser):
    wait_time = between(1, 2)

    @task
    def index_page(self):
        self.client.get("/")

    @task(3)
    def create_movie(self):
        ident = str(random.randint(1,1000))
        for count in range(1000):
            self.client.post("/api/movie", {"name": "locust_%s_%s" % (ident, count),  "rating": random.randint(1,9)})
            time.sleep(0.1)

