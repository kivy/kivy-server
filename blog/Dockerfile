FROM php:5.6-fpm

ENV TINI_VERSION v0.13.2

RUN set -ex \
    && apt-get update \
    && apt-get install -y libpng12-dev libjpeg-dev && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install gd mysqli opcache

RUN set -ex \
    && { \
        echo 'opcache.memory_consumption=128'; \
        echo 'opcache.interned_strings_buffer=8'; \
        echo 'opcache.max_accelerated_files=4000'; \
        echo 'opcache.revalidate_freq=60'; \
        echo 'opcache.fast_shutdown=1'; \
        echo 'opcache.enable_cli=1'; \
    } > /usr/local/etc/php/conf.d/opcache-recommended.ini

COPY custom-php.ini /usr/local/etc/php/conf.d/
COPY start.sh /

RUN set -ex \
    && apt-get update \
    && apt-get install -y cron curl \
    && curl -L https://github.com/krallin/tini/releases/download/$TINI_VERSION/tini > /tini \
    && chmod +x /tini \
    && chmod +x /start.sh

ENTRYPOINT ["/tini", "-g", "-vv", "--"]
CMD ["/start.sh"]
