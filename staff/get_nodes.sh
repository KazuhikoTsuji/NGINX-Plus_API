#!/bin/sh

. ./target.txt

curl -sX GET "http://$TARGET_IP:$TARGET_PORT/api/3/http/upstreams/$UPSTREAM/servers/" -H "accept: application/json" | sed 's/\,/\n/g' | sed -e 's/\[//' -e 's/\]//' | sed '${s/$/\n/}' | sed "/\"id\"*/s/^/---------\n/" | sed '$a ---------'
