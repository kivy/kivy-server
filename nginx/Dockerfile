FROM nginx:1.11.5-alpine

RUN set -ex \
    && apk add --no-cache openssl bash dcron tini curl \
    && mkdir -p /web/acme \
    && curl -L https://raw.githubusercontent.com/Neilpang/acme.sh/master/acme.sh > /web/acme/acme.sh \
    && chmod +x /web/acme/acme.sh \
    && rm /etc/nginx/conf.d/*

COPY ./nginx/conf/*.conf /etc/nginx/
COPY ./nginx/conf/sites-enabled/kivy.org.conf /etc/nginx/conf.d/
COPY ./secrets/file/nginx/dhparam.pem /etc/nginx/certs/
COPY ./nginx/start.sh /start.sh

RUN set -ex \
    && chmod +x /start.sh

ENTRYPOINT ["/sbin/tini", "-g", "-vv", "--"]
CMD ["/start.sh"]
