FROM debian:12

# openssl = para generar el certificado SSL autofirmado
RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

# Genera un certificado SSL autofirmado para HTTPS
# -x509 = tipo de certificado, -nodes = sin contraseña en la clave
# -days 365 = valido un año, -subj = para que dominio es
RUN openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx.key \
    -out /etc/ssl/certs/nginx.crt \
    -subj "/CN=jpuerto-.42.fr"

COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

# daemon off = ejecuta en primer plano para que el contenedor no se pare
ENTRYPOINT ["nginx", "-g", "daemon off;"]
