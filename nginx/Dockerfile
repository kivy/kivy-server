FROM nginx:1.13.0-alpine

RUN set -ex \
    && apk add --no-cache curl openssl bash dcron tini \
    && rm /etc/nginx/conf.d/*

ENV ACME_VERSION 2.6.6
RUN set -ex \
    && curl -L https://github.com/Neilpang/acme.sh/raw/$ACME_VERSION/acme.sh > /usr/local/bin/acme.sh \
    && chmod +x /usr/local/bin/acme.sh

COPY conf/*.conf /etc/nginx/
COPY conf/sites-enabled/kivy.org.conf /etc/nginx/conf.d/

COPY start.sh tls.sh /
RUN set -ex \
    && chmod +x /start.sh /tls.sh

ENTRYPOINT ["/sbin/tini", "-g", "--"]
CMD ["/start.sh"]
