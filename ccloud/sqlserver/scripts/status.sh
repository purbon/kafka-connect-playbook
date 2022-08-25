#!/usr/bin/env bash

curl -X GET \
     -H "Content-Type: application/json" \
     http://localhost:18083/connectors/debezium-sqlserver-source/status | jq .
