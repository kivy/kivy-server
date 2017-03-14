set -e

if [ "$BACKUP_MODE" != "none" ]; then
  if [ ! -f /root/.my.cnf ]; then
    cat << EOF > /root/.my.cnf
[mysql]
user=root
password=$MYSQL_ROOT_PASSWORD

[mysqldump]
user=root
password=$MYSQL_ROOT_PASSWORD
EOF
  fi

  if [ ! -f /root/.rclone.conf ]; then
    cat << EOF > /root/.rclone.conf
[s3]
type = s3
env_auth = false
access_key_id = $AWS_ACCESS_KEY_ID
secret_access_key = $AWS_SECRET_ACCESS_KEY
region = $AWS_S3_REGION
endpoint =
location_constraint =
acl =
server_side_encryption =
EOF
  fi
fi

exec "$@"
