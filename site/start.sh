#!/bin/sh

if [ ! -f /etc/periodic/site-update ]; then
  cat << EOF > /etc/periodic/site-update
*/10 * * * * cd /web/site && git fetch -a && git reset --hard origin/master >> /dev/null 2>&1

EOF
  chmod 0644 /etc/periodic/site-update
fi

/usr/sbin/crond -f
