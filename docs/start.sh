#!/bin/sh

if [ ! -f /root/.ssh/authorized_keys ]; then
  mkdir /root/.ssh && echo -e "$TRAVIS_KEY" > /root/.ssh/authorized_keys

  if [ -d ~/.ssh ] && [ -w ~/.ssh ]; then
      chown -R root:root ~/.ssh && chmod 700 ~/.ssh/
      if [ "$(ls -A ~/.ssh)" ]; then
        chmod 600 ~/.ssh/*
      fi
  fi
fi

/usr/sbin/sshd -D -e
