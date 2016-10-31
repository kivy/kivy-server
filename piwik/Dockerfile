FROM php:5.6-fpm

MAINTAINER pierre@piwik.org

RUN apt-get update && apt-get install -y \
      libjpeg-dev \
      libfreetype6-dev \
      libgeoip-dev \
      libpng12-dev \
      libldap2-dev \
      ssmtp \
      zip \
 && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-freetype-dir=/usr --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
 	&& docker-php-ext-install -j$(nproc) gd mbstring mysql pdo_mysql zip ldap

RUN pecl install APCu geoip

ENV PIWIK_VERSION 2.17.0

RUN curl -fsSL -o piwik.tar.gz \
      "https://builds.piwik.org/piwik-${PIWIK_VERSION}.tar.gz" \
 && curl -fsSL -o piwik.tar.gz.asc \
      "https://builds.piwik.org/piwik-${PIWIK_VERSION}.tar.gz.asc" \
 && export GNUPGHOME="$(mktemp -d)" \
 && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 814E346FA01A20DBB04B6807B5DBD5925590A237 \
 && gpg --batch --verify piwik.tar.gz.asc piwik.tar.gz \
 && rm -r "$GNUPGHOME" piwik.tar.gz.asc \
 && tar -xzf piwik.tar.gz -C /usr/src/ \
 && rm piwik.tar.gz \
 && chfn -f 'Piwik Admin' www-data

RUN curl -fsSL -o /usr/src/piwik/misc/GeoIPCity.dat.gz http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz \
 && gunzip /usr/src/piwik/misc/GeoIPCity.dat.gz

COPY docker-entrypoint.sh /entrypoint.sh

VOLUME /var/www/html



# FROM piwik:2.17.0

COPY custom-php.ini /usr/local/etc/php/conf.d/
COPY common.config.ini.php /usr/src/piwik/config/
COPY start.sh /
# COPY ssmtp.conf /etc/ssmtp/

RUN set -ex \
    && apt-get update \
    && apt-get install -y cron \
    && chmod +x /start.sh \
    && chmod +x /entrypoint.sh \
    && curl -L https://github.com/krallin/tini/releases/download/v0.10.0/tini > /tini \
    && chmod +x /tini \
    && cd /usr/src/piwik \
    && ln -sr piwik.js pw.js \
    && ln -sr piwik.php pw.php

ENTRYPOINT ["/tini", "-g", "-vv", "--", "/entrypoint.sh"]
CMD ["/start.sh"]
