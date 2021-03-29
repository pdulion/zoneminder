build: zm/ffmpeg
	DOCKER_BUILDKIT=1 docker-compose build --progress=plain
.PHONY: image

zm/ffmpeg:
	mkdir -p zm/ffmpeg
	wget -O zm/ffmpeg/deb-multimedia-keyring.deb \
	  https://www.deb-multimedia.org/pool/main/d/deb-multimedia-keyring/deb-multimedia-keyring_2016.8.1_all.deb
	wget zm/ffmpeg/ffmpeg-src.tar.bz2 https://ffmpeg.org/releases/ffmpeg-4.3.2.tar.bz2 -O - \
	  | tar -xjC zm/ffmpeg --strip-components 1

up:
	docker-compose up -d
.PHONY: up

down:
	docker-compose down
.PHONY: down
