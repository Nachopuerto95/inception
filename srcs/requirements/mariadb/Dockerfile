FROM debian:12

# Actualizar e instalar MariaDB
RUN apt-get update && \
    apt-get install -y mariadb-server && \
    apt-get clean

RUN mkdir -p /var/log/mysql && \
    chown -R mysql:mysql /var/log/mysql

# Copiar el archivo de configuración
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Asegurar los permisos de los directorios necesarios
RUN mkdir -p /var/lib/mysql /var/run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /var/run/mysqld && \
    chmod 777 /var/lib/mysql /var/run/mysqld

EXPOSE 3306

# Copiar el script de inicio y asegurarse de que sea ejecutable
COPY ./tools/initdb.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/initdb.sh

# Evitar la inicialización en el Dockerfile, se hará en el script de inicio
ENTRYPOINT [ "/usr/local/bin/initdb.sh" ]