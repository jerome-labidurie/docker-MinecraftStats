# MinecraftStats Docker file
FROM python:3-slim

ARG buildDate

LABEL maintainer="jerome@labidurie.fr"
LABEL buildDate=$buildDate

RUN apt-get update && apt-get install -y git \
    && rm -rf /var/lib/apt/lists/*

# database update frequency (minutes)
ENV MS_UPDATE_FREQ=10
# listening port for http server
ENV MS_LISTEN_PORT=8000

RUN mkdir /config/

WORKDIR /usr/src/app
COPY start.sh .
COPY cron.sh .

RUN git clone --depth 1 https://github.com/pdinklag/MinecraftStats.git

EXPOSE ${MS_LISTEN_PORT}

CMD /usr/src/app/start.sh -u ${MS_UPDATE_FREQ} -p ${MS_LISTEN_PORT}
