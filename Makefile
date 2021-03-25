DOCKER_TAG?=latest

default:

build:
	docker build --rm -t ghcr.io/riposo/cmd:$(DOCKER_TAG) .

run: docker.build
	docker run --rm -it --entrypoint /bin/bash ghcr.io/riposo/cmd:$(DOCKER_TAG)
