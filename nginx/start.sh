#!/bin/sh

if [ ! -f /etc/periodic/certs-update ]; then
  cat << EOF > /etc/periodic/certs-update
0 8 * * * /web/acme/acme.sh --webroot /web/acme --home /web/acme/data -d kivy.org -d www.kivy.org -d wiki.kivy.org -d blog.kivy.org -d pw.kivy.org -d dba.kivy.org --renewAll --reloadcmd "/usr/sbin/nginx -s reload" >> /cron.log 2>&1

EOF
  chmod 0644 /etc/periodic/certs-update
  mkfifo -m 666 /cron.log
fi

/usr/sbin/crond
nginx

tail -n 0 -s 10 -f /cron.log
