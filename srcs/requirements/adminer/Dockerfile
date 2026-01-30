FROM debian:12

# php-cgi = interprete PHP para servir Adminer
# php-mysql = extension para conectar con MariaDB
RUN apt-get update && apt-get install -y \
    php-cgi \
    php-mysql \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Descarga Adminer (un solo archivo PHP para gestionar bases de datos)
RUN mkdir -p /var/www/adminer \
    && curl -L https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php \
       -o /var/www/adminer/index.php

EXPOSE 8081

# php -S = servidor web integrado de PHP, sin necesidad de nginx
ENTRYPOINT ["php", "-S", "0.0.0.0:8081", "-t", "/var/www/adminer"]
