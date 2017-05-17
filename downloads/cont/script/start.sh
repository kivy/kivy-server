#!/bin/sh
set -e

if [ "$BACKUP_MODE" != "none" ]; then
  /cont/script/backup.sh
fi

if [ ! -f /etc/periodic/clean-ci ]; then
  cat << EOF > /etc/periodic/clean-ci
$(shuf -i0-59 -n1) 0 * * * /cont/script/remove-wheels.sh -d /web/downloads/appveyor/kivy --older-than 30 --keep-last 18 >> /dev/null 2>&1
$(shuf -i0-59 -n1) 0 * * * /cont/script/remove-wheels.sh -d /web/downloads/appveyor/kivent --older-than 30 --keep-last 48 >> /dev/null 2>&1

EOF
  chmod 0644 /etc/periodic/clean-ci
fi

if [ ! -f /root/.ssh/authorized_keys ]; then
  mkdir -p /root/.ssh
  mv /authorized_keys /root/.ssh/authorized_keys

  if [ -d ~/.ssh ] && [ -w ~/.ssh ]; then
    chown -R root:root ~/.ssh && chmod 700 ~/.ssh/
    if [ "$(ls -A ~/.ssh)" ]; then
      chmod 600 ~/.ssh/*
    fi
  fi
fi

/usr/sbin/crond
/usr/sbin/sshd -D -e
