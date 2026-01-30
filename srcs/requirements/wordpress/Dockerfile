FROM debian:12

# php-fpm = interprete PHP. php-mysql/curl/xml/mbstring = extensiones que necesita WordPress
# mariadb-client = para poder esperar a que MariaDB arranque
RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    php-curl \
    php-xml \
    php-mbstring \
    php-redis \
    curl \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# wp-cli = herramienta de linea de comandos para instalar y configurar WordPress
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY tools/setup-wp.sh /usr/local/bin/setup-wp.sh
RUN chmod +x /usr/local/bin/setup-wp.sh

# Directorio que php-fpm necesita para su socket/pid
RUN mkdir -p /run/php

EXPOSE 9000

ENTRYPOINT ["setup-wp.sh"]
