#!/bin/sh

. ./target.txt

read -p "which node do you need to delete? Please enter ID of node.: " ID
HOST=`curl -sX GET "http://$TARGET_IP:$TARGET_PORT/api/3/http/upstreams/$UPSTREAM/servers/$ID" -H "accept: application/json" | sed 's/\,/\n/g' | sed -e 's/\[//' -e 's/\]//' | sed '${s/$/\n/}' | grep -A 2 ^\{\"id\": | awk -F':' '{if($1~"server") print $2}' | tr -d \"`
PORT=`curl -sX GET "http://$TARGET_IP:$TARGET_PORT/api/3/http/upstreams/$UPSTREAM/servers/$ID" -H "accept: application/json" | sed 's/\,/\n/g' | sed -e 's/\[//' -e 's/\]//' | sed '${s/$/\n/}' | grep -A 2 ^\{\"id\": | awk -F':' '{if($1~"server") print $3}' | tr -d \"`
WEIGHT=`curl -sX GET "http://$TARGET_IP:$TARGET_PORT/api/3/http/upstreams/$UPSTREAM/servers/$ID" -H "accept: application/json" | sed 's/\,/\n/g' | sed -e 's/\[//' -e 's/\]//' | sed '${s/$/\n/}' | grep -A 2 ^\{\"id\": | awk -F':' '{if($1~"weight") print $2}' | tr -d \"`
read -p "You are about to delete following node from existing environment.
        [$HOST:$PORT weight:$WEIGHT]
Do you want to proceed? [y/n] " ANSWER
if [ "$ANSWER" = "y" ];
then
  curl -X DELETE "http://$TARGET_IP:$TARGET_PORT/api/3/http/upstreams/$UPSTREAM/servers/$ID" -H "accept: application/json" > /dev/null 2>&1
  exit 0
else
  exit 1
fi
