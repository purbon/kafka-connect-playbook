#!/usr/bin/env bash

i="0"
while true; do
  if [[ "$i" -ge '3' ]]; then
    break;
  fi
  docker exec schema-registry /scripts/send-data.sh
  i=$[$i+1]
  sleep 5
done
