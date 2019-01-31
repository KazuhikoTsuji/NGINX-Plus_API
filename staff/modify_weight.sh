#!/bin/sh

. ./target.txt

read -p "Which node do you modify? Please enter ID of node.: " ID
HOST=`curl -sX GET "http://$TARGET_IP:$TARGET_PORT/api/3/http/upstreams/$UPSTREAM/servers/$ID" -H "accept: application/json" | sed 's/\,/\n/g' | sed -e 's/\[//' -e 's/\]//' | sed '${s/$/\n/}' | grep -A 2 ^\{\"id\": | awk -F':' '{if($1~"server") print $2}' | tr -d \"`
PORT=`curl -sX GET "http://$TARGET_IP:$TARGET_PORT/api/3/http/upstreams/$UPSTREAM/servers/$ID" -H "accept: application/json" | sed 's/\,/\n/g' | sed -e 's/\[//' -e 's/\]//' | sed '${s/$/\n/}' | grep -A 2 ^\{\"id\": | awk -F':' '{if($1~"server") print $3}' | tr -d \"`
WEIGHT=`curl -sX GET "http://$TARGET_IP:$TARGET_PORT/api/3/http/upstreams/$UPSTREAM/servers/$ID" -H "accept: application/json" | sed 's/\,/\n/g' | sed -e 's/\[//' -e 's/\]//' | sed '${s/$/\n/}' | grep -A 2 ^\{\"id\": | awk -F':' '{if($1~"weight") print $2}' | tr -d \"`
echo "---------"
echo "Current status is [$HOST:$PORT weight:$WEIGHT]."
read -p "Please enter new value of weight.: " NEW_WEIGHT
read -p "You are about to modify value of weight as follow.
	[$HOST:$PORT weight:$WEIGHT] to [$HOST:$PORT weight:$NEW_WEIGHT}.
Do you want to proceed? [y/n] " ANSWER
if [ "$ANSWER" = "y" ];
then
  curl -X PATCH "http://$TARGET_IP:$TARGET_PORT/api/3/http/upstreams/$UPSTREAM/servers/$ID" -H "accept: application/json" -H "Content-Type: application/json" -d "{ \"weight\": \"$NEW_WEIGHT\"}" > /dev/null 2>&1
  exit 0
else
  exit 1
fi
