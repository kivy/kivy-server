set -e

_CMD=""

while test $# -gt 0
do
    case "$1" in
        --cron)
            _CMD="cron"
            ;;
    esac
    shift
done

if [ "$_CMD" = "cron" ]; then
  mysqldump --databases $MYSQL_DATABASE --add-drop-database --skip-add-drop-table --skip-lock-tables --single-transaction --routines --triggers --events > $MYSQL_DATABASE.sql
  tar cJf $MYSQL_DATABASE.sql.txz $MYSQL_DATABASE.sql --remove-files
  /usr/local/bin/rclone copy --no-traverse $MYSQL_DATABASE.sql.txz $AWS_S3_PREFIX
  rm $MYSQL_DATABASE.sql.txz
  exit
fi

if [ ! -d var/lib/mysql/mysql ]; then
  docker-entrypoint.sh mysqld &
  sleep 20
  killall --wait mysqld
fi

if [ "$BACKUP_MODE" = "restore" ]; then
  docker-entrypoint.sh mysqld &
  sleep 20
  rclone copy --no-traverse $AWS_S3_PREFIX/$MYSQL_DATABASE.sql.txz .
  tar xf $MYSQL_DATABASE.sql.txz && rm $MYSQL_DATABASE.sql.txz
  mysql < $MYSQL_DATABASE.sql && rm $MYSQL_DATABASE.sql
  killall --wait mysqld
fi

if [ "$BACKUP_MODE" = "backup" ]; then
  if [ ! -f /etc/cron.d/s3-backup ]; then
    cat << EOF > /etc/cron.d/s3-backup
$BASE_BACKUP_CRON root AWS_S3_PREFIX=$AWS_S3_PREFIX MYSQL_DATABASE=$MYSQL_DATABASE /backup.sh --cron >> /cron.log 2>&1

EOF
    chmod 0644 /etc/cron.d/s3-backup
    mkfifo -m 666 /cron.log
  fi
  tail -n 0 -s 10 -f /cron.log &
  /etc/init.d/cron restart
fi
