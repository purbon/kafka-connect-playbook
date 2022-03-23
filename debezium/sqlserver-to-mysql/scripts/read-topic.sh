#!/usr/bin/env bash

docker exec kafka-connect kafka-avro-console-consumer --bootstrap-server broker:9092 \
                                                --property schema.registry.url=http://schema-registry:8081 \
                                                --property print.key=true --property key.separator="-" \
                                                --topic server1.dbo.customers --from-beginning
