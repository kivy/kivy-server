FROM piwik:3.0.4-fpm

ENV TINI_VERSION v0.14.0

COPY custom-php.ini /usr/local/etc/php/conf.d/
COPY common.config.ini.php /usr/src/piwik/config/
COPY start.sh /

RUN set -ex \
    && apt-get update \
    && apt-get install -y cron \
    && chmod +x /start.sh \
    && curl -Lf https://github.com/krallin/tini/releases/download/$TINI_VERSION/tini > /tini \
    && chmod +x /tini

ENTRYPOINT ["/tini", "-g", "--", "/entrypoint.sh"]
CMD ["/start.sh"]
