FROM alpine:3.5

RUN set -ex \
    && apk add --no-cache bash openssh rsync tini \
    && echo -e "PasswordAuthentication no" >> /etc/ssh/sshd_config \
    && echo -e "ChallengeResponseAuthentication no" >> /etc/ssh/sshd_config \
    && echo -e "Port 2457" >> /etc/ssh/sshd_config \
    && ssh-keygen -A

COPY start.sh /
RUN set -ex \
    && chmod +x /start.sh

EXPOSE 2457

ENTRYPOINT ["/sbin/tini", "-g", "--"]
CMD ["/start.sh"]
