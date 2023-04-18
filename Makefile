PROJECT_NAME  ?= xxx
REPO_NAME     ?= default
REGISTRY      ?= us-docker.pkg.dev

login: ## [project] Log-in to registry
	gcloud auth login
	gcloud auth configure-docker ${REGISTRY}

build: ## [project] Build images
	docker build --platform linux/amd64 --no-cache -f php/Dockerfile -t ${REGISTRY}/${PROJECT_NAME}/${REPO_NAME}/nginx:latest .
	docker build --platform linux/amd64 --no-cache -f nginx/Dockerfile -t ${REGISTRY}/${PROJECT_NAME}/${REPO_NAME}/php:latest .

push: ## [project] Push images
	docker push ${REGISTRY}/${PROJECT_NAME}/${REPO_NAME}/nginx
	docker push ${REGISTRY}/${PROJECT_NAME}/${REPO_NAME}/php

deploy: ## [project] Deploy to Cloud Run
	gcloud run services replace service.yaml

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
