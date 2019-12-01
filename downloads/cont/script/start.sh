#!/bin/sh
set -e

if [ "$BACKUP_MODE" != "none" ]; then
  /cont/script/backup.sh
fi

if [ ! -f /etc/periodic/clean-ci ]; then
  cat << EOF > /etc/periodic/clean-ci
$(shuf -i0-59 -n1) 0 * * * /cont/script/remove-wheels.sh -d /web/downloads/appveyor/kivy --older-than 7 --keep-last 20 >> /dev/null 2>&1
$(shuf -i0-59 -n1) 0 * * * /cont/script/remove-wheels.sh -d /web/downloads/appveyor/kivent --older-than 7 --keep-last 48 >> /dev/null 2>&1
$(shuf -i0-59 -n1) 0 * * * /cont/script/remove-wheels.sh -d /web/downloads/ci/linux/kivy --older-than 7 --keep-last 10 >> /dev/null 2>&1
$(shuf -i0-59 -n1) 0 * * * /cont/script/remove-wheels.sh -d /web/downloads/ci/osx/kivy --older-than 7 --keep-last 10 >> /dev/null 2>&1
$(shuf -i0-59 -n1) 0 * * * /cont/script/remove-wheels.sh -d /web/downloads/ci/osx/app --keep-last 6 >> /dev/null 2>&1

EOF
  chmod 0644 /etc/periodic/clean-ci
fi

if [ ! -f /etc/periodic/pypi-server-ci ]; then
  cat << EOF > /etc/periodic/pypi-server-ci
$(shuf -i0-59 -n1) 0 * * * /cont/script/pypi_server.sh

EOF
  chmod 0644 /etc/periodic/pypi-server-ci
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
