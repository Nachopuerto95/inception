FROM debian:buster

RUN sed -i 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y php php-fpm php-mysqli php-mysql mariadb-client curl wget tar

RUN mkdir -p /var/www/html && \
    chown -R root:root /var/www/html

WORKDIR /var/www/html

# Instalar WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz --strip-components=1 && \
    rm latest.tar.gz

RUN chown -R root:root /var/www/html

EXPOSE 9000

COPY conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf
COPY tools/auto_conf.sh /auto_conf.sh

RUN chmod +x /auto_conf.sh

CMD ["/auto_conf.sh"]
