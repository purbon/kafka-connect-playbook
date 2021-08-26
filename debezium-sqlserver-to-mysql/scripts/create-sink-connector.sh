#!/usr/bin/env bash

echo "Creating JDBC sink connector"

curl -i -X POST -H "Accept:application/json" \
    -H  "Content-Type:application/json" http://localhost:18083/connectors/ \
    -d '{
      "name": "jdbc-sink-connector",
      "config": {
        "connector.class": "io.confluent.connect.jdbc.JdbcSinkConnector",
        "tasks.max": "2",
        "topics.regex": "server1\\.dbo\\.(.*)",
        "connection.url": " jdbc:mysql://db:3306",
        "dialect.name" : "CustomMySqlJdbcDialect",
        "connection.user": "root",
        "connection.password": "confluent",
        "insert.mode": "upsert",
        "auto.create": "false",
        "auto.evolve": "false",
        "pk.mode": "record_key",
        "pk.fields": "id",
        "delete.enabled": "true",
        "table.name.format": "demo.${topic}",
        "transforms":"ReplaceField,dropPrefix",
        "transforms.ReplaceField.type": "org.apache.kafka.connect.transforms.ReplaceField$Value",
        "transforms.ReplaceField.blacklist": "__op,__deleted",
        "transforms.dropPrefix.type":"org.apache.kafka.connect.transforms.RegexRouter",
        "transforms.dropPrefix.regex":"server1.dbo.(.*)",
        "transforms.dropPrefix.replacement":"$1"
      }
    }'

#    "transforms":"dropPrefix",
#    "transforms.dropPrefix.type":"org.apache.kafka.connect.transforms.RegexRouter",
#    "transforms.dropPrefix.regex":"server1.dbo.(.*)",
#    "transforms.dropPrefix.replacement":"demo.$1"
