# GeeksHubs DevOps Bootcamp 2020

## Juan Manuel Medina

This repo is still very much a work in progress.

The MERN application used in the project is taken from https://github.com/samaronybarros/movies-app, modified where needed to add testing and integration with a CI/CD pipeline.

Development requires [Skaffold](https://skaffold.dev/) and a running Kubernetes cluster. My development environment is Ubuntu 20.04.1 LTS running on Windows Subsystem for Linux v2 plus Kubernetes running on Docker-Desktop.

Start a development environment by running

```
$ skaffold dev
```

at the root directory of the project.

The CI/CD pipeline uses Github Actions.

The application will be deployed to a Kubernetes cluster running on the Google Kubernetes Engine.

### To Do

- Github actions for deploying the application
- Github actions for deploying the GCP infrastructure
- Use a Kubernetes statefulSet to provide persistence to MongoDb
- Include cert-manager to obtain proper TLS certs
- Include a monitoring solution
- Include stress tests
- And (hopefully) more ;)
  - Add infrastructure tests (Inspec? Terratest?)
  - Support a multi-zone cluster
  - Streamline dev/prod k8s manifests (kustomize? Helm?)
