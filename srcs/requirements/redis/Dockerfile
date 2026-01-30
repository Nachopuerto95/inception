FROM debian:12

RUN apt-get update && apt-get install -y \
    redis-server \
    && rm -rf /var/lib/apt/lists/*

COPY conf/redis.conf /etc/redis/redis.conf

EXPOSE 6379

# Redis en primer plano con la configuracion personalizada
ENTRYPOINT ["redis-server", "/etc/redis/redis.conf"]
