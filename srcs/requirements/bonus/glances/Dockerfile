FROM debian:12

RUN apt-get update \
    && apt-get install -y python3 python3-pip \
    && pip3 install --break-system-packages glances fastapi uvicorn jinja2 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

EXPOSE 61208

CMD ["glances", "-w"]