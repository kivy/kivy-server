FROM mysql:5.7.16

ENV TINI_VERSION v0.13.2

RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates wget \
    && wget -O /tini https://github.com/krallin/tini/releases/download/$TINI_VERSION/tini \
    && chmod +x /tini \
    && apt-get purge -y --auto-remove ca-certificates wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/*

COPY start.sh /

RUN set -ex \
    && chmod +x /start.sh

ENTRYPOINT ["/tini", "-g", "--"]
CMD ["/start.sh"]
