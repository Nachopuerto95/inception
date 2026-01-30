#!/bin/bash

FTP_PASSWORD=$(cat /run/secrets/ftp_password)

# Crea el directorio seguro que vsftpd necesita
mkdir -p /var/run/vsftpd/empty

# Crea el usuario FTP si no existe, con home en el volumen de WordPress
if ! id "$FTP_USER" &>/dev/null; then
    useradd -m -d /var/www/html "$FTP_USER"
    echo "$FTP_USER:$FTP_PASSWORD" | chpasswd
fi

# Ejecuta vsftpd en primer plano
exec vsftpd /etc/vsftpd.conf
