# GeeksHubs DevOps Bootcamp 2020 - Final Project

## Overview

The MERN application used in the project is taken from https://github.com/samaronybarros/movies-app, modified where needed to add testing and integration with a CI/CD pipeline.

A separate application called Hello is also included. This is just a simple "hello, world"-style app that comes in handy for troubleshooting.

## Development environment

Development requires [Skaffold](https://skaffold.dev/) and a running Kubernetes cluster.

The development environment used to write this project was comprised of:

- Ubuntu 20.04.1 LTS running on Windows Subsystem for Linux v2
- Docker-Desktop v19.03.12
- Kubernetes v1.16.6
- Make
- Skaffold v1.13.1
- Terraform v0.13.0

Start a development environment by running

```
$ make dev
```

at the root directory of the project. This makes sure that skaffold is running on the correct K8s context. This context can be specified in the environment variable `SKAFFOLD_CONTEXT`. It defaults to "docker-desktop".

### Stress testing

A simple stress testing script using [Locust](https://locust.io/) is included in the locustfile.py file in the root directory of the project. It can be run in a Docker container, so it is not necessary to install python, pip or locust itself on the dev machine. The script can be started by running

```
$ make stress
```

## Production

The CI/CD pipeline uses Github Actions to automate infrastructure provisioning, application testing, Docker image builds and deployment of Kubernetes manifests.

The application will be deployed to a Kubernetes cluster running on the Google Kubernetes Engine.

### To Do

- Document GCP requirements and manual config
- Document Github Actions config and workflow
- ✔ Github actions for deploying the application
- ✔ Github actions for deploying the GCP infrastructure
- ✔ Include cert-manager to obtain proper TLS certs
- ✔ Include a monitoring solution
- ✔ Include stress tests
- And (hopefully) more ;)
  - Add healthchecks to all deployments/services
  - Use a Kubernetes statefulSet to provide persistence to MongoDb
  - Add infrastructure tests (Inspec? Terratest?)
  - Support a multi-zone cluster
  - Streamline dev/prod k8s manifests (kustomize? Helm?)
  - Automated build and use of tagged, version-pinned images instead of `latest` in production
  - Full-fledged GitOps with ArgoCD? Flux? Jenkins X? Tekton?
