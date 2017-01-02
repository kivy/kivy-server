FROM piwik:3.0.0

ENV TINI_VERSION v0.13.2

COPY custom-php.ini /usr/local/etc/php/conf.d/
COPY common.config.ini.php /usr/src/piwik/config/
COPY start.sh /

RUN set -ex \
    && apt-get update \
    && apt-get install -y cron \
    && chmod +x /start.sh \
    && curl -L https://github.com/krallin/tini/releases/download/$TINI_VERSION/tini > /tini \
    && chmod +x /tini \
    && cd /usr/src/piwik \
    && ln -sr piwik.js pw.js \
    && ln -sr piwik.php pw.php

ENTRYPOINT ["/tini", "-g", "-vv", "--", "/entrypoint.sh"]
CMD ["/start.sh"]
