FROM alpine:3.5

RUN set -ex \
    && apk add --no-cache dcron bash openssh rsync tini \
    && echo -e "PasswordAuthentication no" >> /etc/ssh/sshd_config \
    && echo -e "ChallengeResponseAuthentication no" >> /etc/ssh/sshd_config \
    && echo -e "Port 2458" >> /etc/ssh/sshd_config \
    && ssh-keygen -A

ENV RCLONE_VERSION 1.35
RUN set -ex \
    && apk add --no-cache ca-certificates curl \
    && curl -L "https://github.com/ncw/rclone/releases/download/v${RCLONE_VERSION}/rclone-v${RCLONE_VERSION}-linux-amd64.zip" > /rclone.zip \
    && unzip rclone.zip && mv rclone-v${RCLONE_VERSION}-linux-amd64/rclone /usr/local/bin/rclone \
    && rm rclone.zip && rm -R rclone-v${RCLONE_VERSION}-linux-amd64 \
    && chmod +x /usr/local/bin/rclone \
    && apk del curl

COPY .env/file/downloads/.rclone.conf /root/

COPY ./downloads/start.sh /
RUN set -ex \
    && chmod +x /start.sh

EXPOSE 2458

ENTRYPOINT ["/sbin/tini", "-g", "--"]
CMD ["/start.sh"]
