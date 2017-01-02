FROM alpine:3.4

ENV RCLONE_VERSION 1.35

RUN set -ex \
    && apk add --no-cache dcron curl bash git openssh rsync tini \
    && curl -L "https://github.com/ncw/rclone/releases/download/v${RCLONE_VERSION}/rclone-v${RCLONE_VERSION}-linux-amd64.zip" > /rclone.zip \
    && unzip rclone.zip && mv rclone-v${RCLONE_VERSION}-linux-amd64/rclone /usr/local/bin/rclone \
    && rm rclone.zip && rm -R rclone-v${RCLONE_VERSION}-linux-amd64 \
    && chmod +x /usr/local/bin/rclone \
    && mkdir web && cd web && git clone https://github.com/kivy/kivy-website.git site \
    && echo -e "PasswordAuthentication no" >> /etc/ssh/sshd_config \
    && echo -e "ChallengeResponseAuthentication no" >> /etc/ssh/sshd_config \
    && echo -e "Port 2457" >> /etc/ssh/sshd_config \
    && ssh-keygen -A \
    && apk del curl

COPY ./site/start.sh /
COPY ./secrets/file/site/.rclone.conf /root/

RUN set -ex \
    && chmod +x /start.sh

EXPOSE 2457

ENTRYPOINT ["/sbin/tini", "-g", "--"]
CMD ["/start.sh"]
