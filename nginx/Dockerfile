FROM nginx:1.11.8-alpine

ENV ACME_VERSION 2.6.6

RUN set -ex \
    && apk add --no-cache openssl bash dcron tini curl \
    && mkdir -p /web/acme \
    && curl -L https://raw.githubusercontent.com/Neilpang/acme.sh/$ACME_VERSION/acme.sh > /web/acme/acme.sh \
    && chmod +x /web/acme/acme.sh \
    && rm /etc/nginx/conf.d/*

COPY ./nginx/conf/*.conf /etc/nginx/
COPY ./nginx/conf/sites-enabled/kivy.org.conf /etc/nginx/conf.d/
COPY .env/file/nginx/kivy-dhparam.pem /etc/nginx/certs/
COPY ./nginx/start.sh /start.sh

RUN set -ex \
    && chmod +x /start.sh

ENTRYPOINT ["/sbin/tini", "-g", "--"]
CMD ["/start.sh"]
