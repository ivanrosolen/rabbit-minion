#!/bin/bash

COUNTER=1

echo "Host:"
read rabbit_host

echo "User:"
read rabbit_user

echo "Password:"
read rabbit_pwd

echo "Vhost (%2f):"
read vhost

echo "Exchange:"
read exchange

echo "Routing Key:"
read routingKey

while IFS='' read -r line || [[ -n "$line" ]]; do

    result=$(curl -s -i -u $rabbit_user:$rabbit_pwd -H "content-type:application/json" \
    -XPOST -d "{\"properties\":{},\"routing_key\":\"$routingKey\",\"payload\":\"$line\",\"payload_encoding\":\"string\"}" \
    http://$rabbit_host:15672/api/exchanges/$vhost/$exchange/publish)


    echo "$COUNTER >>> $line"

    COUNTER=$[$COUNTER +1]

done < "$1"