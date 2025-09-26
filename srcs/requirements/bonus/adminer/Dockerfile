FROM debian:12

RUN apt-get update && \
    apt-get install -y apache2 php php-mysql libapache2-mod-php wget curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html
RUN wget https://www.adminer.org/latest.php -O /var/www/html/index.php
RUN rm -f /var/www/html/index.html

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

RUN sed -i 's/80/8080/g' /etc/apache2/ports.conf
RUN sed -i 's/:80/:8080/g' /etc/apache2/sites-available/000-default.conf

EXPOSE 8080

CMD ["apache2ctl", "-D", "FOREGROUND"]