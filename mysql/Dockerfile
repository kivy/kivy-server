FROM mysql:5.7.38-debian

ENV RCLONE_VERSION v1.42

RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends cron xz-utils unzip ca-certificates wget \
    && wget -O /rclone.zip "https://downloads.rclone.org/$RCLONE_VERSION/rclone-$RCLONE_VERSION-linux-amd64.zip" \
    && unzip rclone.zip && mv rclone-$RCLONE_VERSION-linux-amd64/rclone /usr/local/bin/rclone \
    && rm -r rclone.zip rclone-$RCLONE_VERSION-linux-amd64 \
    && chmod +x /usr/local/bin/rclone \
    && apt-get purge -y --auto-remove unzip wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/*

COPY entry.sh start.sh backup.sh /
RUN set -ex \
    && chmod +x /entry.sh /start.sh /backup.sh

ENTRYPOINT ["/entry.sh"]
CMD ["/start.sh"]
