#!/bin/sh

if [ ! -f /etc/periodic/site-docs-update ]; then
  cat << EOF > /etc/periodic/site-update
*/10 * * * * /sync.sh

EOF
  chmod 0644 /etc/periodic/site-docs-update
fi

/usr/sbin/crond -f
