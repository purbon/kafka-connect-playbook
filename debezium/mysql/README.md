# Example pipeline Database to Database

## Setup

MySQL -> [Debezium CDC] -> Kafka -> [JDBC Sink Connector] -> MysqlDB

Tables:

* customers : server1.dbo.customers
* cities : server1.db0.cities
