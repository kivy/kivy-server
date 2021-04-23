FROM alpine:3.7

RUN set -ex \
    && apk add --no-cache dcron bash openssh rsync nano \
    && echo -e "PasswordAuthentication no" >> /etc/ssh/sshd_config \
    && echo -e "ChallengeResponseAuthentication no" >> /etc/ssh/sshd_config \
    && echo -e "Port 2458" >> /etc/ssh/sshd_config \
    && ssh-keygen -A

ENV RCLONE_VERSION v1.42
RUN set -ex \
    && apk add --no-cache ca-certificates curl \
    && curl -Lf "https://github.com/ncw/rclone/releases/download/${RCLONE_VERSION}/rclone-${RCLONE_VERSION}-linux-amd64.zip" > /rclone.zip \
    && unzip rclone.zip && mv rclone-${RCLONE_VERSION}-linux-amd64/rclone /usr/local/bin/rclone \
    && rm rclone.zip && rm -R rclone-${RCLONE_VERSION}-linux-amd64 \
    && chmod +x /usr/local/bin/rclone \
    && apk del curl

COPY .env/file/downloads/authorized_keys /

COPY downloads/cont /cont
RUN set -ex \
    && chmod +x /cont/script/*.sh

EXPOSE 2458

ENTRYPOINT ["/cont/script/entry.sh"]
CMD ["/cont/script/start.sh"]
