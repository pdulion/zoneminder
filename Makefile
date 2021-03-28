build: zm/download
	DOCKER_BUILDKIT=1 docker-compose build --progress=plain
.PHONY: image

zm/download:
	mkdir -p zm/download
	wget -O zm/download/ffmpegtar.bz2 https://ffmpeg.org/releases/ffmpeg-4.3.2.tar.bz2

up:
	docker-compose up -d
.PHONY: up

down:
	docker-compose down
.PHONY: down
