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
  /usr/local/bin/rclone sync /web/blog $AWS_S3_PREFIX/wp
  exit
fi

if [ "$BACKUP_MODE" = "restore" ]; then
  /usr/local/bin/rclone sync $AWS_S3_PREFIX/wp /web/blog
fi

if [ "$BACKUP_MODE" = "backup" ]; then
  if [ ! -f /etc/cron.d/s3-backup ]; then
    cat << EOF > /etc/cron.d/s3-backup
$BASE_BACKUP_CRON root AWS_S3_PREFIX=$AWS_S3_PREFIX /backup.sh --cron >> /cron.log 2>&1

EOF
    chmod 0644 /etc/cron.d/s3-backup
    mkfifo -m 666 /cron.log
  fi
  tail -n 0 -s 10 -f /cron.log &
  # /etc/init.d/cron restart
fi
