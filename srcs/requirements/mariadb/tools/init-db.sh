#!/bin/bash

# Lee las contraseñas desde Docker secrets (archivos montados en /run/secrets/)
DB_PASSWORD=$(cat /run/secrets/db_password)
DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

# Solo inicializa si la base de datos no existe aun
if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
    # Crea las tablas internas del sistema de MariaDB
    mysql_install_db --datadir=/var/lib/mysql --user=mysql

    # --bootstrap ejecuta comandos SQL sin arrancar el servidor completo
    mysqld --user=mysql --bootstrap <<EOF
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF
fi

# exec reemplaza el proceso actual por mysqld (queda como PID 1, en primer plano)
exec mysqld --user=mysql
