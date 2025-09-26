FROM debian:12

RUN apt-get update && \
    apt-get install -y mariadb-server && \
    apt-get clean

RUN mkdir -p /var/log/mysql && \
    chown -R mysql:mysql /var/log/mysql

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN mkdir -p /var/lib/mysql /var/run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /var/run/mysqld && \
    chmod 777 /var/lib/mysql /var/run/mysqld

EXPOSE 3306

COPY ./tools/initdb.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/initdb.sh

ENTRYPOINT [ "/usr/local/bin/initdb.sh" ]