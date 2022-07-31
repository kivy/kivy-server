#!/bin/sh
set -e

if [ ! -f /etc/periodic/certs-update ]; then
  cat << EOF > /etc/periodic/certs-update
0 8 * * * /tls.sh >> /cron.log 2>&1

EOF
  chmod 0644 /etc/periodic/certs-update
  mkfifo -m 666 /cron.log
fi

#if [ "$BOOTSTRAP_TLS" = "true" ]; then
#  /tls.sh
#fi

/usr/sbin/crond
nginx

tail -n 0 -s 10 -f /cron.log
