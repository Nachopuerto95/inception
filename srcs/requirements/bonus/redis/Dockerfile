FROM debian:12

RUN apt-get update && \
    apt-get install -y redis-server && \
    rm -rf /var/lib/apt/lists/*

COPY conf/redis.conf /etc/redis/redis.conf

WORKDIR /data

EXPOSE 6379

CMD ["redis-server", "--protected-mode", "no"]