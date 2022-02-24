#!/usr/bin/env bash

#curl -X PUT -H "Content-Type: application/vnd.schemaregistry.v1+json" \
#    --data '{"compatibility": "NONE"}' \
#    http://localhost:8081/config/dbo-value

echo "Creating Debezium SQL Server source connector"
curl -s -X PUT \
     -H "Content-Type: application/json" \
     --data '{
               "connector.class": "FileStreamSource",
               "name": "filesource",
               "tasks.max": "1",
               "file": "/tmp/test.txt",
               "topic": "${keyvault:test-secret?ttl=60000:username}"
          }' \
     http://localhost:18083/connectors/filesource/config | jq .

sleep 5

# "transforms": "ExtractField",
# "transforms.ExtractField.type":"org.apache.kafka.connect.transforms.ExtractField$Key",
# "transforms.ExtractField.field":"after"
