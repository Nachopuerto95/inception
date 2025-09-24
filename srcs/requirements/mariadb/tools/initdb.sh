#!/bin/bash

set -e

mysqld_safe --datadir=/var/lib/mysql &

until mysqladmin ping --silent; do
	echo "Esperando a que MariaDB esté lista..."
	sleep 2
done

mysql -u root <<-EOSQL
	CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
	CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';
	GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';
	ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
	FLUSH PRIVILEGES;
EOSQL

mysqladmin -u root -p"${SQL_ROOT_PASSWORD}" shutdown


exec mysqld_safe --datadir=/var/lib/mysql