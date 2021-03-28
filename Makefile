NAME=zoneminder
VERSION=1.34

build:
	DOCKER_BUILDKIT=1 docker-compose build --progress=plain
.PHONY: image
