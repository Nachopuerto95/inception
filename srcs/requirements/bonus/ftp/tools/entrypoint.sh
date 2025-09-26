#!/bin/sh

set -e

mkdir -p /var/www/html/files/$FTPUSER
chown -R $FTPUSER:$FTPUSER /var/www/html/files/$FTPUSER
chmod 755 /var/www/html/files/$FTPUSER

touch /var/log/xferlog
chmod 644 /var/log/xferlog

grep -q "^local_root=" /etc/vsftpd.conf || \
    echo "local_root=/var/www/html/files/$FTPUSER" >> /etc/vsftpd.conf

exec "$@"
