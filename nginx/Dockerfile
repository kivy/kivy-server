FROM nginx:1.15.0-alpine

RUN set -ex \
    && apk add --no-cache curl openssl bash dcron \
    && rm /etc/nginx/conf.d/*

ENV ACME_VERSION 2.7.8
RUN set -ex \
    && curl -Lf https://github.com/Neilpang/acme.sh/raw/$ACME_VERSION/acme.sh > /usr/local/bin/acme.sh \
    && chmod +x /usr/local/bin/acme.sh

COPY conf/*.conf /etc/nginx/
COPY conf/sites-enabled/kivy.org.conf /etc/nginx/conf.d/

COPY start.sh tls.sh /
RUN set -ex \
    && chmod +x /start.sh /tls.sh

CMD ["/start.sh"]
