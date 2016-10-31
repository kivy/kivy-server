#!/bin/sh

if [ ! -f /etc/periodic/site-update ]; then
  cat << EOF > /etc/periodic/site-update
*/10 * * * * cd /web/site && git fetch -a && git reset --hard origin/master >> /dev/null 2>&1
0 */6 * * * /usr/local/bin/rclone sync gdrive:Kivy/Downloads /web/downloads >> /dev/null 2>&1

EOF
  chmod 0644 /etc/periodic/site-update

  mkdir /root/.ssh && echo -e "$TRAVIS_KEY" > /root/.ssh/authorized_keys

  if [ -d ~/.ssh ] && [ -w ~/.ssh ]; then
      chown -R root:root ~/.ssh && chmod 700 ~/.ssh/
      if [ "$(ls -A ~/.ssh)" ]; then
        chmod 600 ~/.ssh/*
      fi
  fi
fi

/usr/sbin/crond
/usr/sbin/sshd -D -e
