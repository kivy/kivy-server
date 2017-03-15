#!/bin/sh
set -e

DOMAINS="kivy.org www.kivy.org wiki.kivy.org blog.kivy.org pw.kivy.org dba.kivy.org"

FIRST_DOMAIN=$(echo $DOMAINS | { read first _; echo $first; })
KEYPATH=/web/tls/data/certs/$FIRST_DOMAIN/domain.key
FULLCHAINPATH=/web/tls/data/certs/$FIRST_DOMAIN/chain.crt

if [ ! -f $KEYPATH ]; then
  mkdir -p /web/tls/data/certs/$FIRST_DOMAIN
  /usr/local/bin/acme.sh --home /web/tls/data $(printf -- " -d %s" $DOMAINS) \
  --standalone --issue --force --keypath $KEYPATH --fullchainpath $FULLCHAINPATH
  openssl dhparam -out /web/tls/data/certs/$FIRST_DOMAIN/dhparam.pem 2048
else
  if pgrep "nginx" > /dev/null; then
    /usr/local/bin/acme.sh --home /web/tls/data --webroot /web/tls --renewAll \
    --stopRenewOnError --keypath $KEYPATH --fullchainpath $FULLCHAINPATH \
    --reloadcmd "/usr/sbin/nginx -s reload"
  else
    /usr/local/bin/acme.sh --home /web/tls/data --standalone --renewAll \
    --stopRenewOnError --keypath $KEYPATH --fullchainpath $FULLCHAINPATH
  fi
fi
