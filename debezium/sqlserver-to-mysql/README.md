# Example pipeline Database to Database

## Setup

SQL Server -> [Debezium CDC] -> Kafka -> [JDBC Sink Connector] -> MysqlDB

Tables:

* customers : server1.dbo.customers
* cities : server1.db0.cities

## Commands

### Prepare the SQL server database with data

```bash
$> ./scripts/prepare-db.sh
Load inventory.sql to SQL Server
Changed database context to 'testDB'.

(1 rows affected)

(1 rows affected)

(1 rows affected)

(1 rows affected)

(1 rows affected)

(1 rows affected)

(1 rows affected)

(1 rows affected)

(1 rows affected)
Job 'cdc.testDB_capture' started successfully.
Job 'cdc.testDB_cleanup' started successfully.
```

### Setup the Debezium CDC connector

```bash
./scripts/create-cdc-connector.sh
Creating Debezium SQL Server source connector
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  3271  100  1401  100  1870    666    890  0:00:02  0:00:02 --:--:--  1556
{
  "name": "debezium-sqlserver-source",
  "config": {
    "connector.class": "io.debezium.connector.sqlserver.SqlServerConnector",
    "tasks.max": "1",
    "database.hostname": "sqlserver",
    "database.port": "1433",
    "database.user": "sa",
    "database.password": "Password!",
    "database.server.name": "server1",
    "database.dbname": "testDB",
    "database.history.kafka.bootstrap.servers": "broker:9092",
    "database.history.kafka.topic": "schema-changes.inventory",
    "transforms": "InsertField,unwrap",
    "transforms.InsertField.type": "org.apache.kafka.connect.transforms.InsertField$Value",
    "transforms.InsertField.static.field": "MessageSource",
    "transforms.InsertField.static.value": "Kafka Connect framework",
    "transforms.ExtractField.type": "org.apache.kafka.connect.transforms.ExtractField$Key",
    "transforms.ExtractField.field": "id",
    "transforms.unwrap.type": "io.debezium.transforms.ExtractNewRecordState",
    "transforms.unwrap.add.fields": "op",
    "transforms.unwrap.delete.handling.mode": "rewrite",
    "transforms.unwrap.drop.tombstones": "false",
    "key.converter": "io.confluent.connect.avro.AvroConverter",
    "key.converter.schema.registry.url": "http://schema-registry:8081",
    "key.converter.enhanced.avro.schema.support": "true",
    "value.converter": "io.confluent.connect.avro.AvroConverter",
    "value.converter.schema.registry.url": "http://schema-registry:8081",
    "value.converter.enhanced.avro.schema.support": "true",
    "name": "debezium-sqlserver-source"
  },
  "tasks": [],
  "type": "source"
}
```

### Insert a Record

```bash
$>  ./scripts/insert-record.sh
Changed database context to 'testDB'.

(1 rows affected)
```

### Read a topic

```bash
$> ./scripts/read-topic.sh
{"id":1001}-{"id":1001,"first_name":"Sally","last_name":"Thomas","email":"sally.thomas@acme.com","__op":{"string":"r"},"__deleted":{"string":"false"}}
{"id":1002}-{"id":1002,"first_name":"George","last_name":"Bailey","email":"gbailey@foobar.com","__op":{"string":"r"},"__deleted":{"string":"false"}}
{"id":1003}-{"id":1003,"first_name":"Edward","last_name":"Walker","email":"ed@walker.com","__op":{"string":"r"},"__deleted":{"string":"false"}}
{"id":1004}-{"id":1004,"first_name":"Anne","last_name":"Kretchmar","email":"annek@noanswer.org","__op":{"string":"r"},"__deleted":{"string":"false"}}
{"id":1005}-{"id":1005,"first_name":"Luk","last_name":"Skywalker","email":"luk@office.com","__op":{"string":"c"},"__deleted":{"string":"false"}}
```

### List topics created in the cluster

```bash
$> docker-compose exec broker kafka-topics --bootstrap-server broker:29092  --list
__consumer_offsets
_confluent-license
_kafka-connect-configs
_kafka-connect-offsets
_kafka-connect-status
_schemas
schema-changes.inventory
server1
server1.dbo.cities
server1.dbo.customers
```

### Create JDBC sink connector

```bash
$> ./scripts/create-sink-connector.sh
Creating JDBC sink connector
HTTP/1.1 100 Continue

HTTP/1.1 201 Created
Date: Fri, 20 Aug 2021 14:13:48 GMT
Location: http://localhost:18083/connectors/jdbc-sink-connector
Content-Type: application/json
Content-Length: 867
Server: Jetty(9.4.40.v20210413)

{"name":"jdbc-sink-connector","config":{"connector.class":"io.confluent.connect.jdbc.JdbcSinkConnector","tasks.max":"2","topics.regex":"server1\\.dbo\\.(.*)","connection.url":" jdbc:mysql://db:3306","dialect.name":"MySqlDatabaseDialect","connection.user":"root","connection.password":"confluent","insert.mode":"upsert","auto.create":"false","auto.evolve":"false","pk.mode":"record_key","pk.fields":"id","delete.enabled":"true","table.name.format":"demo.${topic}","transforms":"ReplaceField,dropPrefix","transforms.ReplaceField.type":"org.apache.kafka.connect.transforms.ReplaceField$Value","transforms.ReplaceField.blacklist":"__op,__deleted","transforms.dropPrefix.type":"org.apache.kafka.connect.transforms.RegexRouter","transforms.dropPrefix.regex":"server1.dbo.(.*)","transforms.dropPrefix.replacement":"$1","name":"jdbc-sink-connector"},"tasks":[],"type":"sink"}%
```
