#!/bin/sh

if [ ! -f /etc/periodic/downloads-update ]; then
  cat << EOF > /etc/periodic/downloads-update
0 */6 * * * /usr/local/bin/rclone sync gdrive:Kivy/Downloads /web/downloads >> /dev/null 2>&1

EOF
  chmod 0644 /etc/periodic/downloads-update

  mkdir /root/.ssh
  echo -e "$TRAVIS_KEY" > /root/.ssh/authorized_keys
  echo -e "$APPVEYOR_KEY" >> /root/.ssh/authorized_keys

  if [ -d ~/.ssh ] && [ -w ~/.ssh ]; then
      chown -R root:root ~/.ssh && chmod 700 ~/.ssh/
      if [ "$(ls -A ~/.ssh)" ]; then
        chmod 600 ~/.ssh/*
      fi
  fi
fi

/usr/sbin/crond
/usr/sbin/sshd -D -e
