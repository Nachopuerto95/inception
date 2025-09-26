FROM debian:12

ARG FTPUSER
ARG FTPPASS

RUN apt-get update && apt-get install -y vsftpd

RUN useradd -m "$FTPUSER" && echo "$FTPUSER:$FTPPASS" | chpasswd

RUN mkdir -p /var/run/vsftpd/empty

COPY conf/vsftpd.conf /etc/vsftpd.conf

COPY ./tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 21 20 30000-30009

ENTRYPOINT ["/entrypoint.sh"]

CMD ["vsftpd"]
