#!/bin/bash

app=""
script=""

while [[ $# > 1 ]]
do
key="$1"

case $key in
    -a|--app)
    app="$2"
    shift # past argument
    ;;
    -s|--script)
    script="$2"
    shift # past argument
    ;;
    *)
            # unknown option
    ;;
esac
shift # past argument or value
done

if [ "$app" == "" ]; then
  echo "app is missing, usage -a <app-dir>"
  exit
fi

if [ "$script" == "" ]; then
  echo "script is missing, usage -s <script file path>"
  exit
fi

echo APP  = "${app}"
echo SCRIPT     = "${script}"



mycontainer=$(docker-compose -f node-docker-compose.yml run -d  --service-ports web sh -c "cd apps/${app} && pm2 start ${script} && pm2 logs")

echo container started $mycontainer

function clean_up {
  echo removing container $mycontainer
  docker rm -vf  $mycontainer
  exit
}

trap clean_up SIGHUP SIGINT SIGTERM

#docker-compose build
#docker-compose start

# tail all logs
docker logs --follow $mycontainer &

# fswatch is available for linux and osx.
fswatch -0 $app | while read -d "" event
  do
    echo "file changed: ${event}"
    #image=$(docker ps | grep <docker app-name> | cut -d " " -f1 )
    docker exec -t $mycontainer pm2 restart all
  done