FROM alpine:3.7

RUN set -ex \
    && apk add --no-cache bash openssh rsync \
    && echo -e "PasswordAuthentication no" >> /etc/ssh/sshd_config \
    && echo -e "ChallengeResponseAuthentication no" >> /etc/ssh/sshd_config \
    && echo -e "Port 2457" >> /etc/ssh/sshd_config \
    && ssh-keygen -A

COPY .env/file/docs/authorized_keys /

COPY ./docs/start.sh /
RUN set -ex \
    && chmod +x /start.sh

EXPOSE 2457

CMD ["/start.sh"]
