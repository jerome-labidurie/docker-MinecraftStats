#!/bin/bash
# launch update on a regular basis

if [ -z "$1" ]
then
	echo "usage: $0 <minutes>"
	exit 1
fi

cd /usr/src/app/MinecraftStats/

# create default config if not existing
if [ ! -r /config/config.json ]
then
	./makeconfig.py --server /minecraft > /config/config.json
fi

# start "cron"
while [ 1 ]
do
	DATE=$( date +%Y%m%d-%H%M )
	echo "$DATE Updating database ..."
	./update.py /config/config.json
	sleep ${1}m
done
