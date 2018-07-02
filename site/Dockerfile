FROM alpine:3.7

RUN set -ex \
    && apk add --no-cache dcron bash git \
    && mkdir web && cd web && git clone https://github.com/kivy/kivy-website.git site

COPY start.sh /
RUN set -ex \
    && chmod +x /start.sh

CMD ["/start.sh"]
