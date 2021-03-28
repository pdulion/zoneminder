# syntax=docker/dockerfile:experimental
FROM debian:buster-slim
LABEL maintainer="phillip@dulion.com"
ARG version

ENV	LC_ALL="C.UTF-8" \
	LANG="en_US.UTF-8" \
	LANGUAGE="en_US.UTF-8" \
	TZ="Etc/UTC" \
	ZM_VERS="${version}"

RUN \
  --mount=type=bind,target=/var/scripts,source=scripts,ro \
  --mount=type=bind,target=/var/download,source=download,ro \
  --mount=type=cache,target=/var/cache/apt \
  --mount=type=cache,target=/var/lib/apt \
  --mount=type=cache,target=/var/log/apt \
  echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
&& apt-get update \
&& apt-get install -y --no-install-recommends \
    apache2 \
    apt-transport-https \
    ca-certificates \
    libapache2-mod-php \
    gnupg \
    php \
    php-mysql \
    autoconf \
    automake \
    build-essential \
    cmake \
    git-core \
    libass-dev \
    libfreetype6-dev \
    libsdl2-dev \
    libtool \
    libva-dev \
    libvdpau-dev \
    libvorbis-dev \
    libxcb1-dev \
    libxcb-shm0-dev \
    libxcb-xfixes0-dev \
    pkg-config \
    texinfo \
    zlib1g-dev \
    nasm \
    yasm \
    libx265-dev \
    libnuma-dev \
    libvpx-dev \
    libmp3lame-dev \
    libopus-dev \
    libx264-dev \
    libfdk-aac-dev \
&& echo deb https://zmrepo.zoneminder.com/debian/release-${ZM_VERS}} buster/ >> /etc/apt/sources.list \
&& apt-key add /var/scripts/zoneminder.gpg \
&& apt-get update \
&& apt-get install -y --no-install-recommends zoneminder \
&& apt-get clean \
&& adduser www-data video \
&& install /var/scripts/zoneminder /usr/local/bin/zoneminder \
&& mkdir -p \
    /var/cache/zoneminder/cache \
    /var/cache/zoneminder/events \
    /var/cache/zoneminder/images \
    /var/cache/zoneminder/temp \
    /var/log/zm \
    /var/run/zm \
    /tmp/zm \
&& chown -R www-data:www-data \
    /usr/share/zoneminder \
    /var/cache/zoneminder \
    /var/log/zm \
    /var/run/zm \
    /tmp/zm

CMD ["/usr/local/bin/zoneminder"]
