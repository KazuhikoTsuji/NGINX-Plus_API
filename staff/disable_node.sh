#!/bin/sh

. ./target.txt

read -p "Which node do you disable? Please enter ID of node.: " ID
HOST=`curl -sX GET "http://$TARGET_IP:$TARGET_PORT/api/3/http/upstreams/$UPSTREAM/servers/$ID" -H "accept: application/json" | sed 's/\,/\n/g' | sed -e 's/\[//' -e 's/\]//' | sed '${s/$/\n/}' | grep -A 2 ^\{\"id\": | awk -F':' '{if($1~"server") print $2}' | tr -d \"`
PORT=`curl -sX GET "http://$TARGET_IP:$TARGET_PORT/api/3/http/upstreams/$UPSTREAM/servers/$ID" -H "accept: application/json" | sed 's/\,/\n/g' | sed -e 's/\[//' -e 's/\]//' | sed '${s/$/\n/}' | grep -A 2 ^\{\"id\": | awk -F':' '{if($1~"server") print $3}' | tr -d \"`
WEIGHT=`curl -sX GET "http://$TARGET_IP:$TARGET_PORT/api/3/http/upstreams/$UPSTREAM/servers/$ID" -H "accept: application/json" | sed 's/\,/\n/g' | sed -e 's/\[//' -e 's/\]//' | sed '${s/$/\n/}' | grep -A 2 ^\{\"id\": | awk -F':' '{if($1~"weight") print $2}' | tr -d \"`
read -p "You are about to disable following node from existing environment.
        [$HOST:$PORT weight:$WEIGHT]
Do you want to proceed? [y/n] " ANSWER
if [ "$ANSWER" = "y" ];
then
  curl -X PATCH -d '{ "down": true }' -s "http://$TARGET_IP:$TARGET_PORT/api/3/http/upstreams/$UPSTREAM/servers/$ID" > /dev/null 2>&1
  exit 0
else
  exit 1
fi
