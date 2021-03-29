# syntax=docker/dockerfile:experimental
ARG version
FROM pdulion/zm:${version}

RUN \
   --mount=type=bind,target=/var/scripts,source=scripts,ro \
   --mount=type=cache,target=/var/cache/apt \
   --mount=type=cache,target=/var/lib/apt \
   --mount=type=cache,target=/var/log/apt \
   echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
&& apt-get update \
&& apt-get install -y --no-install-recommends \
   apache2 \
   libapache2-mod-php \
   php${PHP_VERSION} \
   php-mysql \
&& a2enmod cgi \
&& a2enmod expires \
&& a2enmod headers \
&& a2enmod php${PHP_VERSION} \
&& a2enmod rewrite \
&& a2enconf zoneminder \
&& echo "ServerName localhost" >> /etc/apache2/apache2.conf \
&& install /var/scripts/zm-web /usr/local/bin/zm-web

STOPSIGNAL SIGWINCH
CMD ["/usr/local/bin/zm-web"]
