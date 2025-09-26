#!/bin/bash

# Verificar si el archivo wp-config.php ya existe
if [ -f /var/www/html/wp-config.php ]; then
    echo "Wordpress already exists"
else
    wp core download --allow-root
    wp config create --dbname=$SQL_DATABASE --dbuser=$SQL_USER --dbpass=$SQL_PASSWORD --dbhost=$SQL_HOSTNAME --allow-root
    wp core install --url=$DOMAIN_NAME --title="$WORDPRESS_TITLE" --admin_user=$WORDPRESS_ADMIN --admin_password=$WORDPRESS_ADMIN_PASS --admin_email=$WORDPRESS_ADMIN_EMAIL --skip-email --allow-root
    wp user create $WORDPRESS_USER $WORDPRESS_EMAIL --role=author --user_pass=$WORDPRESS_USER_PASS --allow-root
    wp theme install hestia --activate --allow-root
fi

/usr/sbin/php-fpm8.2 -F;