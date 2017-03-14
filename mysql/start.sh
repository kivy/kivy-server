set -e

if [ "$BACKUP_MODE" != "none" ]; then
  /backup.sh
fi

docker-entrypoint.sh mysqld
