FROM php:5.6-fpm-alpine

ENV ADMINER_VERSION 4.2.5
ENV ADMINER_COMMIT 53dfafd2ea80e318eded7937252d0c1d9b7a2c93

RUN set -ex \
    && apk add --no-cache tini \
    && docker-php-ext-install mysql pdo_mysql

WORKDIR /web/adminer
COPY ./web /web/adminer
COPY custom-php.ini /usr/local/etc/php/conf.d/

RUN set -ex \
    && curl -L https://www.adminer.org/static/download/${ADMINER_VERSION}/adminer-${ADMINER_VERSION}-en.php > adminer.php \
    && curl -L https://raw.githubusercontent.com/vrana/adminer/${ADMINER_COMMIT}/designs/pepa-linha/adminer.css > adminer.css \
    && echo "#tables {top: 260px;}" >> adminer.css \
    && curl -L https://raw.githubusercontent.com/vrana/adminer/${ADMINER_COMMIT}/plugins/plugin.php > plugins/plugin.php \
    && curl -L https://raw.githubusercontent.com/vrana/adminer/${ADMINER_COMMIT}/plugins/version-noverify.php > plugins/version-noverify.php

ENTRYPOINT ["/sbin/tini", "-g", "-vv", "--"]
CMD ["php-fpm"]
