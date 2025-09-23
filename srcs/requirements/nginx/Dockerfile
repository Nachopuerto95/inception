FROM debian:buster

RUN sed -i 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' /etc/apt/sources.list && \
	apt-get update && \
    apt-get install -y vim curl nginx openssl

RUN mkdir -p /etc/nginx/ssl /var/www/html /var/run/nginx

RUN openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/CN=inception"

RUN chmod 755 /var/www/html && \
    chown -R www-data:www-data /var/www/html

# COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]