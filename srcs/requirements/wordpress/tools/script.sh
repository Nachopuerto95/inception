#!/bin/bash
sleep 10

mkdir -p /run/php && chown -R www-data:www-data /run/php

if [ ! -f /var/www/wordpress/wp-config.php ]; then
	wp config create --allow-root \
		--dbname=$SQL_DATABASE \
		--dbuser=$SQL_USER \
		--dbpass=$SQL_PASSWORD \
		--dbhost=mariadb:3306 --path='/var/www/wordpress'
fi

chown -R www-data:www-data /var/www/wordpress

/usr/sbin/php-fpm7.3 -F