FROM debian:12
RUN apt-get update && \
    apt-get install -y \
    apache2 \
    php \
    php-fpm php-mysql \
	wget \
	curl \
    adminer

RUN mkdir -p /run/php

RUN mkdir -p /var/www/html

RUN wget http://www.adminer.org/latest.php -O /var/www/html/index.php
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

RUN sed -i 's/80/8080/g' /etc/apache2/ports.conf
RUN sed -i 's/:80/:8080/g' /etc/apache2/sites-available/000-default.conf


COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

EXPOSE 9000

CMD ["apache2ctl", "-D", "FOREGROUND"]
