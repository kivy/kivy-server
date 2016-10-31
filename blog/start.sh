#!/bin/sh

if [ ! -f /etc/cron.d/feed-update ]; then
  cat << EOF > /etc/cron.d/feed-update
*/10 * * * * root /usr/bin/curl --silent http://blog.kivy.org/?update_feedwordpress=1

EOF
  chmod 0644 /etc/cron.d/feed-update
fi

/etc/init.d/cron restart
php-fpm
