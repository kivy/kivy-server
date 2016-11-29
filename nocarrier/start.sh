#!/bin/sh

if [ ! -f /etc/periodic/nocarrier ]; then
  for repository in kivy buildozer python-for-android kivy-ios plyer pyjnius pyobjus kivent kivy-designer kivy-sdk-packager kivy-website; do
    cat << EOF >> /etc/periodic/nocarrier
$(shuf -i0-59 -n1) 0 * * * /bin/s6-envdir /etc/nocarrier.d/env $(/usr/local/bin/docker-java-home)/bin/java -jar /app/no-carrier.jar kivy/$repository awaiting-reply 14 >> /cron.log 2>&1

EOF
  done

  chmod 0644 /etc/periodic/nocarrier
  mkfifo -m 666 /cron.log
fi

/usr/sbin/crond

tail -n 0 -s 10 -f /cron.log
