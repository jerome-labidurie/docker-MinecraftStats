#!/bin/bash

function usage() {
	echo "usage: $0 -u <update freq in minutes> -p <http listening port>"
	exit 1
}

# get cmdline parameters
while getopts "hu:p:" OPT
do
	case $OPT in
		h)
			usage
			exit 0
			;;
		u)
			UPDATE_FREQ=$OPTARG
			;;
		p)
			PORT=$OPTARG
			;;
		*)
			echo "unknown option $OPT"
			usage
²			exit 1
	esac
done

if [ -z "$UPDATE_FREQ" -o -z "$PORT" ]
then
	usage
	exit 1
fi

# echo $UPDATE_FREQ,$PORT

cd /usr/src/app/MinecraftStats/

# update to last version
echo "Updating MinecraftStats ..."
git pull

# start "cron"
/usr/src/app/cron.sh $UPDATE_FREQ &

# start webserver
echo "Starting webserver ..."
python -m http.server $PORT &

# Wait for any process to exit
wait -n

# Exit with status of process that exited first
exit $?
