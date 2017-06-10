FROM alpine:3.6

RUN set -ex \
    && apk add --no-cache dcron bash git tini \
    && mkdir web && cd web && git clone https://github.com/kivy/kivy-website.git site

COPY start.sh /
RUN set -ex \
    && chmod +x /start.sh

ENTRYPOINT ["/sbin/tini", "-g", "--"]
CMD ["/start.sh"]
