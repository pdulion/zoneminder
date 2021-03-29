# syntax=docker/dockerfile:experimental
ARG version
FROM pdulion/zm:${version}

RUN \
   --mount=type=cache,target=/var/cache/apt \
   --mount=type=cache,target=/var/lib/apt \
   --mount=type=cache,target=/var/log/apt \
   echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
&& apt-get update \
&& apt-get install -y --no-install-recommends \
   apache2 \
   libapache2-mod-php \
   php \
   php-mysql \
&& a2enmod cgi \
&& a2enmod expires \
&& a2enmod headers \
&& a2enmod php${PHP_VERSION} \
&& a2enmod rewrite \
&& a2enconf zoneminder \
&& echo "ServerName localhost" >> /etc/apache2/apache2.conf

STOPSIGNAL SIGWINCH
CMD ["apache2ctl", "-DFOREGROUND"]
