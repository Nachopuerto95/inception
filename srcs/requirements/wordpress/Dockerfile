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

RUN mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

WORKDIR /var/www/html

RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz --strip-components=1 && \
    rm latest.tar.gz && \
    chown -R www-data:www-data /var/www/html

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

COPY ./tools/script.sh /script.sh
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf
RUN chmod +x /script.sh

CMD ["/script.sh"]
