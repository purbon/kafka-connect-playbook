#!/usr/bin/env bash

echo "Creating a DataGen connector for stock trades"
curl -X PUT \
     -H "Content-Type: application/json" \
     --data '{
                "connector.class": "io.confluent.kafka.connect.datagen.DatagenConnector",
                "kafka.topic": "stock-trades",
                "quickstart": "Stock_Trades",
                "key.converter": "org.apache.kafka.connect.storage.StringConverter",
                "value.converter": "io.confluent.connect.json.JsonSchemaConverter",
                "value.converter.schema.registry.url": "http://schema-registry:8081",
                "value.converter.schemas.enable": "true",
                "max.interval": 100,
                "iterations": 10000000,
                "tasks.max": "1"
                
          }' \
     http://localhost:18083/connectors/datagen-stocktrades/config | jq .

sleep 5

#       CONNECT_VALUE_CONVERTER_SCHEMA_REGISTRY_URL: 'http://schema-registry:8081'
# "transforms": "ExtractField",
# "transforms.ExtractField.type":"org.apache.kafka.connect.transforms.ExtractField$Key",
# "transforms.ExtractField.field":"after"
