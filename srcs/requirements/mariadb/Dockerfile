FROM debian:buster

RUN sed -i 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' /etc/apt/sources.list && \
    apt update && \
    apt install -y mariadb-server

COPY tools/initdb.sh /initdb.sh
RUN chmod +x /initdb.sh

EXPOSE 3306

ENTRYPOINT ["/initdb.sh"]