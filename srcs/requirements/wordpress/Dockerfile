FROM debian:buster

RUN sed -i 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y \
        php7.3 \
        php7.3-fpm \
        php7.3-mysql \
        wget \
        tar \
        curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Crear carpeta y asignar permisos correctos
RUN mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

WORKDIR /var/www/html

# Descargar y extraer WordPress como www-data
USER www-data
RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz --strip-components=1 && \
    rm latest.tar.gz

# Volver a root para copiar script
USER root
COPY ./tools/script.sh /script.sh
RUN chmod +x /script.sh

CMD ["/script.sh"]
