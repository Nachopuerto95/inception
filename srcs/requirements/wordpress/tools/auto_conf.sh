#!/bin/bash
set -e

DB_HOST=${SQL_HOST:-mariadb}

echo "Esperando a que MariaDB esté disponible en $DB_HOST..."
until mysqladmin ping -h"$DB_HOST" -u"$SQL_USER" -p"$SQL_PASSWORD" --silent; do
    echo "Esperando a que MariaDB responda..."
    sleep 2
done

echo "MariaDB lista, configurando WordPress..."

wp config create --allow-root \
    --dbname="$SQL_DATABASE" \
    --dbuser="$SQL_USER" \
    --dbpass="$SQL_PASSWORD" \
    --dbhost="$DB_HOST:3306" \
    --path='/var/www/html'

wp core install \
    --url="$DOMAIN_NAME" \
    --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN_N" \
    --admin_password="$WP_ADMIN_P" \
    --admin_email="$WP_ADMIN_E" \
    --allow-root

wp user create "$WP_U_NAME" "$WP_U_EMAIL" \
    --user_pass="$WP_U_PASS" \
    --role="$WP_U_ROLE" \
    --allow-root

mkdir -p /run/php
exec php-fpm7.3 -F
