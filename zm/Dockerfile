# syntax=docker/dockerfile:experimental
FROM debian:buster-slim
LABEL maintainer="phillip@dulion.com"

ARG version
ENV LC_ALL="C.UTF-8" \
   LANG="en_US.UTF-8" \
   LANGUAGE="en_US.UTF-8" \
   TZ="Etc/UTC" \
   ZM_VERSION="${version}" \
   PHP_VERSION="7.3"

RUN \
   --mount=type=bind,target=/var/ffmpeg,source=ffmpeg,rw \
   --mount=type=bind,target=/var/scripts,source=scripts,ro \
   --mount=type=cache,target=/var/cache/apt \
   --mount=type=cache,target=/var/lib/apt \
   --mount=type=cache,target=/var/log/apt \
   echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
&& apt-get update \
&& apt-get install -y --no-install-recommends \
   apt-transport-https \
   ca-certificates \
   gnupg \
&& echo deb http://www.deb-multimedia.org buster main >> /etc/apt/sources.list \
&& echo deb https://zmrepo.zoneminder.com/debian/release-${ZM_VERSION} buster/ >> /etc/apt/sources.list \
&& apt-key add /var/scripts/zoneminder.gpg \
&& dpkg -i /var/ffmpeg/deb-multimedia-keyring.deb \
&& apt-get update \
&& apt-get install -y --no-install-recommends \
   zoneminder \
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
&& cd /var/ffmpeg \
&& PKG_CONFIG_PATH="/var/ffmpeg/lib/pkgconfig" ./configure \
   --prefix="$HOME/ffmpeg_build" \
   --pkg-config-flags="--static" \
   --extra-cflags="-I/var/ffmpeg/include" \
   --extra-ldflags="-L/var/ffmpeg/lib" \
   --extra-libs="-lpthread -lm" \
   --bindir="/usr/local/bin" \
   --enable-libfdk-aac \
   --enable-gpl \
   --enable-libass \
   --enable-libfreetype \
   --enable-libmp3lame \
   --enable-libopus \
   --enable-libvorbis \
   --enable-libvpx \
   --enable-libx264 \
   --enable-libx265 \
   --enable-nonfree \
&& make -j8 \
&& make install -j8 \
&& apt-get clean \
&& adduser www-data video \
&& install /var/scripts/* /usr/local/bin/ \
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

CMD ["/usr/local/bin/zm"]
