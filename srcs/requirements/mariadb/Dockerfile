# FROM = imagen base del contenedor (debian 12 = penultima estable, requisito del subject)
FROM debian:12

# RUN = ejecuta comandos durante la construccion de la imagen
# apt-get install = instala paquetes. rm -rf limpia cache para reducir tamaño
RUN apt-get update && apt-get install -y \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/*

# COPY = copia archivos de tu maquina al contenedor
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/init-db.sh /usr/local/bin/init-db.sh
# chmod +x = hace el script ejecutable
RUN chmod +x /usr/local/bin/init-db.sh

# Crea el directorio para el socket de MariaDB
RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

# EXPOSE = declara el puerto que usa el contenedor (informativo)
EXPOSE 3306

# ENTRYPOINT = comando que se ejecuta al arrancar el contenedor
ENTRYPOINT ["init-db.sh"]
