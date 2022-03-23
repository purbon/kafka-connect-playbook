#!/usr/bin/env bash

echo "Deleting Debezium SQL Server source connector"
curl -X DELETE \
     -H "Content-Type: application/json" \
     http://localhost:18083/connectors/debezium-sqlserver-source

sleep 2

echo "Deleting JDBC sink connector"

curl -X DELETE http://localhost:18083/connectors/jdbc-sink-connector

sleep 2


echo "Available connectors"

curl -X GET \
     -H "Content-Type: application/json" \
     http://localhost:18083/connectors

# "transforms": "ExtractField",
# "transforms.ExtractField.type":"org.apache.kafka.connect.transforms.ExtractField$Key",
# "transforms.ExtractField.field":"after"
