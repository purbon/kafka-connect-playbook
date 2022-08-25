#!/usr/bin/env bash

source scripts/setup-env.sh

CONNECTOR_PAYLOAD=$(cat << EOC
{
          "connector.class": "io.debezium.connector.sqlserver.SqlServerConnector",
           "tasks.max": "1",
           "database.hostname": "$SQL_SERVER_HOST",
           "database.port": "1433",
           "database.user": "sa",
           "database.password": "$SQL_SERVER_PASSWORD",
           "database.server.name": "server1",
           "database.dbname" : "testDB",
           "database.history.kafka.bootstrap.servers": "$BOOTSTRAP_SERVER",
           "database.history.consumer.security.protocol": "SASL_SSL",
           "database.history.consumer.ssl.endpoint.identification.algorithm": "https",
           "database.history.consumer.sasl.mechanism": "PLAIN",
           "database.history.consumer.sasl.jaas.config": "org.apache.kafka.common.security.plain.PlainLoginModule required username=\"$API_KEY\" password=\"$API_SECRET\";",
           "database.history.producer.security.protocol": "SASL_SSL",
           "database.history.producer.ssl.endpoint.identification.algorithm": "https",
           "database.history.producer.sasl.mechanism": "PLAIN",
           "database.history.producer.sasl.jaas.config": "org.apache.kafka.common.security.plain.PlainLoginModule required username=\"$API_KEY\" password=\"$API_SECRET\";",
           "database.history.kafka.topic": "schema-changes.inventory",
           "transforms": "InsertField,unwrap",
           "transforms.InsertField.type": "org.apache.kafka.connect.transforms.InsertField\$Value",
           "transforms.InsertField.static.field": "MessageSource",
           "transforms.InsertField.static.value": "Kafka Connect framework",
           "transforms.ExtractField.type":"org.apache.kafka.connect.transforms.ExtractField\$Key",
           "transforms.ExtractField.field":"id",
           "transforms.unwrap.type": "io.debezium.transforms.ExtractNewRecordState",
           "transforms.unwrap.add.fields": "op",
           "transforms.unwrap.delete.handling.mode": "rewrite",
           "transforms.unwrap.drop.tombstones": "false",
           "key.converter": "io.confluent.connect.avro.AvroConverter",
           "key.converter.schema.registry.url": "https://psrc-lo5k9.eu-central-1.aws.confluent.cloud",
           "key.converter.enhanced.avro.schema.support": "true",
           "key.converter.basic.auth.credentials.source": "USER_INFO",
           "key.converter.schema.registry.basic.auth.user.info": "$SCHEMA_REGISTRY_AUTH_USER_INFO",
           "value.converter": "io.confluent.connect.avro.AvroConverter",
           "value.converter.schema.registry.url": "https://psrc-lo5k9.eu-central-1.aws.confluent.cloud",
           "value.converter.enhanced.avro.schema.support": "true",
           "value.converter.basic.auth.credentials.source": "USER_INFO",
           "value.converter.schema.registry.basic.auth.user.info": "$SCHEMA_REGISTRY_AUTH_USER_INFO"
     }
EOC
)

#echo $CONNECTOR_PAYLOAD

echo "Creating Debezium SQL Server source connector"
curl -X PUT \
     -H "Content-Type: application/json" \
     --data "$CONNECTOR_PAYLOAD" \
     http://localhost:18083/connectors/debezium-sqlserver-source/config | jq .

sleep 5

# "transforms": "ExtractField",
# "transforms.ExtractField.type":"org.apache.kafka.connect.transforms.ExtractField$Key",
# "transforms.ExtractField.field":"after"
