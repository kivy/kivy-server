FROM mysql:5.7.18

ENV TINI_VERSION v0.14.0
ENV RCLONE_VERSION v1.42

RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends cron xz-utils unzip ca-certificates wget \
    && wget -O /usr/local/bin/tini https://github.com/krallin/tini/releases/download/$TINI_VERSION/tini \
    && chmod +x /usr/local/bin/tini \
    && wget -O /rclone.zip https://github.com/ncw/rclone/releases/download/$RCLONE_VERSION/rclone-$RCLONE_VERSION-linux-amd64.zip \
    && unzip rclone.zip && mv rclone-$RCLONE_VERSION-linux-amd64/rclone /usr/local/bin/rclone \
    && rm -r rclone.zip rclone-$RCLONE_VERSION-linux-amd64 \
    && chmod +x /usr/local/bin/rclone \
    && apt-get purge -y --auto-remove unzip wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/*

COPY entry.sh start.sh backup.sh /
RUN set -ex \
    && chmod +x /entry.sh /start.sh /backup.sh

ENTRYPOINT ["tini", "-g", "--", "/entry.sh"]
CMD ["/start.sh"]
