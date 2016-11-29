#!/bin/sh
set -e

if [ ! -d /etc/nocarrier.d/env ]; then
  mkdir -p /etc/nocarrier.d/env
  echo "$GITHUB_USERNAME" > /etc/nocarrier.d/env/GITHUB_USERNAME
  echo "$GITHUB_PASSWORD" > /etc/nocarrier.d/env/GITHUB_PASSWORD
fi

exec "$@"
