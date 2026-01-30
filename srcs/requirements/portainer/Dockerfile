FROM debian:12

# Portainer = interfaz web para gestionar contenedores Docker
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Descarga el binario de Portainer
RUN curl -L https://github.com/portainer/portainer/releases/download/2.21.4/portainer-2.21.4-linux-amd64.tar.gz \
    -o /tmp/portainer.tar.gz \
    && tar -xzf /tmp/portainer.tar.gz -C /opt \
    && rm /tmp/portainer.tar.gz

EXPOSE 9000

# --bind-http = escucha HTTP en este puerto, --http-disabled=false
ENTRYPOINT ["/opt/portainer/portainer", "--bind", ":9000", "--tunnel-port", "0"]
