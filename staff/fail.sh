#!/bin/sh

. ./target.txt

echo "---------"
echo "Congratulations! operation succeeded!"
echo "Current status is below."
curl -sX GET "http://$TARGET_IP:$TARGET_PORT/api/3/http/upstreams/$UPSTREAM/servers/" -H "accept: app lication/json" | sed 's/\,/\n/g' | sed -e 's/\[//' -e 's/\]//' | sed '${s/$/\n/}' | grep -e ^\{\"id -e ^\"weight -e ^\"server | sed "/\"id\"*/s/^/---------\n/" | sed '$a ---------'
