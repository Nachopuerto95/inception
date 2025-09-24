#!/bin/bash

# Verificar si el archivo wp-config.php ya existe
if [ -f /var/www/html/wp-config.php ]; then
    echo "Wordpress already exists"
else
    wp core download --allow-root
    wp config create --dbname=$SQL_DATABASE --dbuser=$SQL_USER --dbpass=$SQL_PASSWORD --dbhost=$SQL_HOSTNAME --allow-root

    # Instalar WordPress
    wp core install --url=$DOMAIN_NAME --title="$WORDPRESS_TITLE" --admin_user=$WORDPRESS_ADMIM --admin_password=$WORDPRESS_ADMIM_PASS --admin_email=$WORDPRESS_ADMIM_EMAIL --skip-email --allow-root

    # Crear el usuario de WordPress
    wp user create $WORDPRESS_USER $WORDPRESS_EMAIL --role=author --user_pass=$WORDPRESS_USER_PASS --allow-root

    # Instalar y activar el tema
    wp theme install hestia --activate --allow-root
fi

# Ejecutar PHP-FPM
/usr/sbin/php-fpm8.2 -F;