# docker-MinecraftStats
docker file for  https://github.com/pdinklag/MinecraftStats

# usage
```
# build the image
docker build -t minecraftstats .
# remove previously created container
docker rm mcstats
# run the container
docker run -p 8000:8000 --name mcstats \
   --volume /path/to/minecraft/world/minecraft:/minecraft:ro \
   --volume /path/to/config/directory/to/store/config.json/config:/config \
   --env UPDATE_FREQ=60 \
   minecraftstats
# save the image
docker save minecraftstats:latest |gzip > minecraftstats.tgz

```

# variables
* UPDATE_FREQ : frequency in minutes to update MinecraftStats database
* LISTEN_PORT : listening port for the webserver
