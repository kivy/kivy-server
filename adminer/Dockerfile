FROM php:5.6.32-fpm-alpine

ENV ADMINER_VERSION 4.3.1

RUN set -ex \
    && apk add --no-cache tini \
    && docker-php-ext-install mysql pdo_mysql

WORKDIR /web/adminer
COPY ./web /web/adminer
COPY custom-php.ini /usr/local/etc/php/conf.d/

RUN set -ex \
    && curl -Lf https://www.adminer.org/static/download/${ADMINER_VERSION}/adminer-${ADMINER_VERSION}-en.php > adminer.php \
    && curl -Lf https://raw.githubusercontent.com/vrana/adminer/v${ADMINER_VERSION}/designs/pepa-linha/adminer.css > adminer.css \
    && echo "#tables {top: 260px;}" >> adminer.css \
    && curl -Lf https://raw.githubusercontent.com/vrana/adminer/v${ADMINER_VERSION}/plugins/plugin.php > plugins/plugin.php \
    && curl -Lf https://raw.githubusercontent.com/vrana/adminer/v${ADMINER_VERSION}/plugins/version-noverify.php > plugins/version-noverify.php

ENTRYPOINT ["/sbin/tini", "-g", "--"]
CMD ["php-fpm"]
