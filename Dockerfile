# MinecraftStats Docker file
FROM python:3

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

CMD /usr/src/app/start.sh ${UPDATE_FREQ} ${LISTEN_PORT}