#!/usr/bin/env bash

CCLOUD_ENV=env-1234
KAFKA_CLUSTER=lkc-1234


confluent login

confluent environment use $CCLOUD_ENV
confluent kafka cluster use $KAFKA_CLUSTER
confluent api-key create --resource $KAFKA_CLUSTER

confluent kafka topic create server1
confluent kafka topic create server1.dbo.cities
confluent kafka topic create server1.dbo.customers
