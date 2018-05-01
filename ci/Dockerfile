FROM alpine:3.6

RUN set -ex \
    && apk add --no-cache curl

COPY ci/script.sh /

RUN \
    chmod +x /script.sh && \
    (crontab -l 2>/dev/null; \
        echo "$APPVEYOR_SCHEDULE /script.sh \
        >> /var/log/syslog 2>&1" \
    )| crontab -

# run CRON daemon in foreground
# to keep the container running
ENTRYPOINT crond -f -L /var/log/syslog
