FROM alpine:3.12

RUN set -ex \
    && apk add --no-cache dcron bash git rsync \
    && git clone https://github.com/kivy/kivy-website-docs.git \
    && mkdir web && cd web && mkdir doc

COPY ./docs/start.sh /
COPY ./docs/sync.sh /
RUN set -ex \
    && chmod +x /start.sh \
    && chmod +x /sync.sh

CMD ["/start.sh"]
