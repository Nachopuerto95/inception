FROM debian:buster

RUN sed -i 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' /etc/apt/sources.list && \
    apt-get update  && \
    apt-get install -y \
		mariadb-server && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

COPY tools/initdb.sh /initdb.sh

RUN chmod +x /initdb.sh

CMD ["/initdb.sh"]