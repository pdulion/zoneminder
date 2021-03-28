NAME=zoneminder
VERSION=1.34

image:
	DOCKER_BUILDKIT=1 docker build --progress=plain --tag=$(NAME):$(VERSION) .
.PHONY: image
