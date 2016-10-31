#!/bin/sh

if [ ! -f /etc/cron.d/piwik-archive ]; then
  cat << EOF > /etc/cron.d/piwik-archive
0 * * * * root /usr/local/bin/php /var/www/html/console core:archive >> /dev/null 2>&1

EOF
  chmod 0644 /etc/cron.d/piwik-archive
fi

/etc/init.d/cron restart
php-fpm
