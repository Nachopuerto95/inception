FROM debian:12

# vsftpd = servidor FTP ligero y seguro
RUN apt-get update && apt-get install -y \
    vsftpd \
    && rm -rf /var/lib/apt/lists/*

COPY conf/vsftpd.conf /etc/vsftpd.conf
COPY tools/setup-ftp.sh /usr/local/bin/setup-ftp.sh
RUN chmod +x /usr/local/bin/setup-ftp.sh

# 21 = puerto de control FTP, 21100-21110 = puertos para modo pasivo
EXPOSE 21 21100-21110

ENTRYPOINT ["setup-ftp.sh"]
