FROM php:5.6.40-fpm

RUN set -ex \
    && apt-get update \
    && apt-get install -y libpng-dev libjpeg-dev && rm -rf /var/lib/apt/lists/* \
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

COPY entry.sh start.sh backup.sh /
RUN set -ex \
    && chmod +x /entry.sh /start.sh /backup.sh

ENV RCLONE_VERSION v1.42

RUN set -ex \
    && apt-get update \
    && apt-get install -y cron curl unzip \
    && curl --insecure -Lf "https://downloads.rclone.org/$RCLONE_VERSION/rclone-$RCLONE_VERSION-linux-amd64.zip" > rclone.zip \
    && unzip rclone.zip && mv rclone-$RCLONE_VERSION-linux-amd64/rclone /usr/local/bin/rclone \
    && rm -r rclone.zip rclone-$RCLONE_VERSION-linux-amd64 \
    && chmod +x /usr/local/bin/rclone \
    && apt-get purge -y --auto-remove unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/*

ENTRYPOINT ["/entry.sh"]
CMD ["/start.sh"]
