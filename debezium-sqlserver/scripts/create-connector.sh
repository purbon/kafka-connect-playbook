#!/usr/bin/env bash

echo "Creating Debezium SQL Server source connector"
curl -X PUT \
     -H "Content-Type: application/json" \
     --data '{
               "connector.class": "io.debezium.connector.sqlserver.SqlServerConnector",
                    "tasks.max": "1",
                    "database.hostname": "sqlserver",
                    "database.port": "1433",
                    "database.user": "sa",
                    "database.password": "Password!",
                    "database.server.name": "server1",
                    "database.dbname" : "testDB",
                    "database.history.kafka.bootstrap.servers": "broker:9092",
                    "database.history.kafka.topic": "schema-changes.inventory",
                    "transforms": "ExtractField",
                    "transforms.ExtractField.type":"org.apache.kafka.connect.transforms.ExtractField$Key",
                    "transforms.ExtractField.field":"after"
          }' \
     http://localhost:18083/connectors/debezium-sqlserver-source/config | jq .

sleep 5
