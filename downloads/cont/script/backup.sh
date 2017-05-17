#!/bin/sh
set -e

_CMD=""

while [ ${#} -gt 0 ]; do
  case "${1}" in
    --cron)
    _CMD="cron"
    ;;
  esac
  shift
done

if [ "$_CMD" = "cron" ]; then
  /usr/local/bin/rclone sync --exclude-from /cont/config/exclude-backup.conf /web/downloads $AWS_S3_PREFIX
  exit
fi

if [ "$BACKUP_MODE" = "restore" ]; then
  /usr/local/bin/rclone sync $AWS_S3_PREFIX /web/downloads
fi

if [ "$BACKUP_MODE" = "backup" ]; then
  if [ ! -f /etc/periodic/s3-backup ]; then
    cat << EOF > /etc/periodic/s3-backup
$BASE_BACKUP_CRON AWS_S3_PREFIX=$AWS_S3_PREFIX /cont/script/backup.sh --cron >> /cron.log 2>&1

EOF
    chmod 0644 /etc/periodic/s3-backup
    mkfifo -m 666 /cron.log
  fi
  tail -n 0 -s 10 -f /cron.log &
  # /usr/sbin/crond
fi
