FROM debian:12

RUN apt-get update && apt-get install -y \
    nginx \
    && rm -rf /var/lib/apt/lists/*

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY tools/index.html /var/www/static/index.html

EXPOSE 8080

ENTRYPOINT ["nginx", "-g", "daemon off;"]
