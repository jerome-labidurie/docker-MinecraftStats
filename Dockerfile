# MinecraftStats Docker file
FROM python:3-slim

RUN apt-get update && apt-get install -y git \
    && rm -rf /var/lib/apt/lists/*

# database update frequency (minutes)
ENV UPDATE_FREQ=10
# listening port for http server
ENV LISTEN_PORT=8000

RUN mkdir /config/

WORKDIR /usr/src/app
COPY start.sh .
COPY cron.sh .

RUN git clone https://github.com/pdinklag/MinecraftStats.git

EXPOSE ${LISTEN_PORT}

CMD /usr/src/app/start.sh -u ${UPDATE_FREQ} -p ${LISTEN_PORT}
