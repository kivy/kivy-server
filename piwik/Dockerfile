FROM piwik:3.2.0-fpm

COPY custom-php.ini /usr/local/etc/php/conf.d/
COPY common.config.ini.php /usr/src/piwik/config/
COPY start.sh /

RUN set -ex \
    && apt-get update \
    && apt-get install -y cron \
    && chmod +x /start.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/start.sh"]
