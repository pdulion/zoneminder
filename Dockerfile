# syntax=docker/dockerfile:experimental
FROM debian:buster-slim
LABEL maintainer="phillip@dulion.com"

ENV	LC_ALL="C.UTF-8" \
	LANG="en_US.UTF-8" \
	LANGUAGE="en_US.UTF-8" \
	TZ="Etc/UTC" \
	PHP_VERS="7.4" \
	ZM_VERS="1.34"

RUN \
  --mount=type=bind,target=/var/scripts,source=scripts,ro \
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
&& echo deb https://zmrepo.zoneminder.com/debian/release-1.34 buster/ >> /etc/apt/sources.list \
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
    /tmp/zm \
&& chown -R www-data:www-data \
    /usr/share/zoneminder \
    /var/cache/zoneminder \
    /var/log/zm \
    /tmp/zm
