# docker-MinecraftStats
Docker file for  https://github.com/pdinklag/MinecraftStats

This container is not intended to be used in production as it's only based on python simple http server.

# Minecraft world
The default configuration expect the minecraft world to be accessible in `/minecraft` and the world to be named **world**.

You can mount it by using the `--volume` option of your docker run command. eg :
```
--volume /home/user/.minecraft/saves/:/minecraft
```

This can be later changed via MinecraftStats json configuration file.

# MinecraftStats configuration

The container uses /config/config.json file for the configuration of MinecraftStats.
If not present a default one will be created during startup.

If you want to modify it, make this directory accessible to your host via the `--volume` option. eg:
```
--volume /home/user/MinecraftStats-config/:/config
```

# Variables
The container behaviour can be modified via environment variables of docker (`--env` option)

* **MS_UPDATE_FREQ**
  * frequency in minutes to update MinecraftStats database
  * default: 10
* **MS_LISTEN_PORT**
  * listening port for the python webserver
  * default: 8000


# Example usage
```
# build the image
docker build --build-arg buildDate=$(date +'%Y-%m-%d') \
             -t minecraftstats .

# remove previously created container (if needed)
docker rm mcstats

# run the container
docker run -p 8000:8000 --name mcstats \
   --volume /path/to/minecraft/world/minecraft:/minecraft:ro \
   --volume /path/to/config/directory/to/store/config.json/config:/config \
   --env MS_UPDATE_FREQ=60 \
   minecraftstats

# save the image (eg for backup)
docker save minecraftstats:latest |gzip > minecraftstats.tar.gz

```
