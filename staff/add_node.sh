#!/bin/sh

. ./target.txt

read -p "Please provide IP ADDRESS or FQDN(e.g: 192.168.1.XX or node.example.local): " HOST
read -p "Please provide Port number(e.g: 80): " PORT
read -p "Please provide Value of weight(e.g: 1 2 3 ...): " WEIGHT
read -p "You are about to add following node for existing environment.
        [$HOST:$PORT weight:$WEIGHT]
Do you want to proceed? [y/n] " ANSWER
if [ "$ANSWER" = "y" ];
then
  curl -X POST "http://$TARGET_IP:$TARGET_PORT/api/3/http/upstreams/$UPSTREAM/servers/" -H "accept: application/json" -H "Content-Type: application/json" -d "{ \"server\": \"$HOST:$PORT\", \"weight\": \"$WEIGHT\"}"  > /dev/null 2>&1
  exit 0
else
  exit 1
fi
