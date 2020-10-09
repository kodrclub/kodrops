
SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

ifeq ($(origin .RECIPEPREFIX), undefined)
  $(error This Make does not support .RECIPEPREFIX. Please use GNU Make 4.0 or later)
endif
.RECIPEPREFIX = >

# ---------------------------------------------------------------------------

SKAFFOLD_CONTEXT ?= "docker-desktop"
CURRENT_CONTEXT := "$(shell kubectl config current-context)"

help:
>	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
.PHONY: help

#
# Use this to start the dev environment instead of directly running
# $ skaffold dev
#
# This prevents accidentally trying to run skaffold on the wrong context
# (maybe production?!?)
#
dev: ## Runs local development environment making sure we are using the right Kubernetes context
ifneq ($(CURRENT_CONTEXT), $(SKAFFOLD_CONTEXT))
>	@kubectl config use-context $(SKAFFOLD_CONTEXT)
endif
>	@skaffold dev
.PHONY: dev

stress: ## Starts locust and loads locustfile.py in order to run stress tests
> @docker run -p 8089:8089 -v $$PWD:/mnt/locust locustio/locust -f /mnt/locust/locustfile.py
.PHONY: stress

test-manifests: ## Tests all kubernetes manifests using kubeval
> @kubeval infra/k8s/*
> @kubeval infra/k8s-dev/*
> @kubeval --skip-kinds Issuer infra/k8s-prod/*
> @kubeval --skip-kinds Issuer infra/k8s-prod-monit/*
.PHONY: test-manifests

test-prod-manifests: ## Tests production kubernetes manifests using kubeval
> @kubeval infra/k8s/*
> @kubeval --skip-kinds Issuer infra/k8s-prod/*
> @kubeval --skip-kinds Issuer infra/k8s-prod-monit/*
.PHONY: test-prod-manifests

deploy-prod-manifests: ## Deploys production kubernetes manifests. Mainly for use in pipeline.
ifeq ($(CURRENT_CONTEXT), $(SKAFFOLD_CONTEXT))
> @echo "You appear to be targetting the development kubernetes context. No manifests will be deployed."
else
> @kubectl apply            -f infra/k8s-prod/kodrops-ns.yaml
> @kubectl apply -n kodrops -f infra/k8s
> @kubectl apply -n kodrops -f infra/k8s-prod
> @kubectl apply -n monit   -f infra/k8s-prod-monit
> @kubectl scale -n monit deploy kodrops-xyz-grafana --replicas=0
> @kubectl scale -n monit deploy kodrops-xyz-grafana --replicas=1
endif
.PHONY: deploy-prod-manifests