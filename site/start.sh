#!/bin/sh

# Forces the first website build at startup
FORCE_BUILD=1 /update_and_build.sh

/usr/sbin/crond -f