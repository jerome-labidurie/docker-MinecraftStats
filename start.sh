#!/bin/bash


/usr/src/app/cron.sh $1 &

cd /usr/src/app/MinecraftStats/
echo "Starting webserver ..."
python -m http.server $2 &

# Wait for any process to exit
wait -n

# Exit with status of process that exited first
exit $?
