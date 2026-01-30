#!/bin/bash

# Lee contraseñas desde Docker secrets
DB_PASSWORD=$(cat /run/secrets/db_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)

# Espera a que MariaDB este lista antes de continuar
until mysqladmin ping -h mariadb -u "$MYSQL_USER" -p"$DB_PASSWORD" --silent; do
    sleep 2
done

cd /var/www/html

# Solo instala WordPress si no esta configurado aun
if [ ! -f wp-config.php ]; then
    # Descarga los archivos de WordPress
    wp core download --allow-root

    # Crea wp-config.php con los datos de conexion a la base de datos
    wp config create --allow-root \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$DB_PASSWORD" \
        --dbhost=mariadb

    # Instala WordPress: crea tablas en la BD y el usuario administrador
    wp core install --allow-root \
        --url="https://$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL"

    # Crea un segundo usuario con rol editor (requisito del subject)
    wp user create --allow-root \
        "$WP_USER" "$WP_USER_EMAIL" \
        --role=editor \
        --user_pass="$WP_USER_PASSWORD"
    # --- BONUS: Redis cache ---
    # WP_REDIS_HOST = nombre del contenedor de Redis en la red Docker
    wp config set WP_REDIS_HOST redis --allow-root
    # WP_REDIS_PORT = puerto donde escucha Redis
    wp config set WP_REDIS_PORT 6379 --allow-root
    # WP_CACHE = activa el sistema de cache de WordPress
    wp config set WP_CACHE true --raw --allow-root
    # Instala y activa el plugin que conecta WordPress con Redis
    wp plugin install redis-cache --activate --allow-root
    # Activa la conexion Redis (crea el archivo object-cache.php)
    wp redis enable --allow-root
fi

# -F = primer plano (foreground)
exec php-fpm8.2 -F
