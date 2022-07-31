FROM alpine:3.16

RUN set -ex \
    && apk add --no-cache dcron bash git python3 py3-pip nodejs npm \
    && mkdir web && cd web && git clone https://github.com/kivy/kivy-website.git && cd kivy-website && git checkout master

COPY start.sh /
RUN set -ex \
    && chmod +x /start.sh

COPY update_and_build.sh /
RUN set -ex \
    && chmod a+x /update_and_build.sh

RUN echo '*/5  *  *  *  *    /update_and_build.sh' > /etc/crontabs/root

CMD ["/start.sh"]
