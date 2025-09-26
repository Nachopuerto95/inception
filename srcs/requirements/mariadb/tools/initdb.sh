#!/bin/bash

set -e

mysqld_safe --datadir=/var/lib/mysql &

until mysqladmin ping --silent; do
	echo "Esperando a que MariaDB esté lista..."
	sleep 2
done

if [ ! -d "/var/lib/mysql/${SQL_DATABASE}" ]; then
    mysql -u "${ROOT_USR}" -p"${SQL_ROOT_PASSWORD}" <<EOF
CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'%';
FLUSH PRIVILEGES;
ALTER USER '${ROOT_USR}'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
EOF
fi

mysqladmin -u "${ROOT_USR}" -p"${SQL_ROOT_PASSWORD}" shutdown

exec mysqld --datadir=/var/lib/mysql --user=mysql