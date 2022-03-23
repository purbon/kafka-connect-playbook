#!/usr/bin/env bash

echo "Creating Debezium SQL Server source connector"
curl -X PUT \
     -H "Content-Type: application/json" \
     --data '{
                "connector.class": "io.debezium.connector.mysql.MySqlConnector",
                "tasks.max": "1",
                "database.hostname": "db",
                "database.port": "3306",
                "database.user": "root",
                "database.password": "confluent",
                "database.server.id": "184054",
                "database.server.name": "server1",
                "database.dbname" : "demo",
                "database.history.kafka.bootstrap.servers": "broker:9092",
                "database.history.kafka.topic": "schema-changes.inventory",
                "table.include.list" : "demo.(.*)",
                "transforms": "InsertField,unwrap",
                "transforms.InsertField.type": "org.apache.kafka.connect.transforms.InsertField$Value",
                "transforms.InsertField.static.field": "MessageSource",
                "transforms.InsertField.static.value": "Kafka Connect framework",
                "transforms.ExtractField.type":"org.apache.kafka.connect.transforms.ExtractField$Key",
                "transforms.ExtractField.field":"id",
                "transforms.unwrap.type": "io.debezium.transforms.ExtractNewRecordState",
                "transforms.unwrap.add.fields": "op",
                "transforms.unwrap.delete.handling.mode": "rewrite",
                "transforms.unwrap.drop.tombstones": "false",
                "key.converter": "io.confluent.connect.avro.AvroConverter",
                "key.converter.schema.registry.url": "http://schema-registry:8081",
                "key.converter.enhanced.avro.schema.support": "true",
                "value.converter": "io.confluent.connect.avro.AvroConverter",
                "value.converter.schema.registry.url": "http://schema-registry:8081",
                "value.converter.enhanced.avro.schema.support": "true"
          }' \
     http://localhost:18083/connectors/mysql-source/config | jq .

sleep 5

# "transforms": "ExtractField",
# "transforms.ExtractField.type":"org.apache.kafka.connect.transforms.ExtractField$Key",
# "transforms.ExtractField.field":"after"
