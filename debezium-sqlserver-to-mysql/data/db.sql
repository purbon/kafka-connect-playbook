GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'replicator' IDENTIFIED BY 'replpass';
GRANT SELECT, RELOAD, SHOW DATABASES, REPLICATION SLAVE, REPLICATION CLIENT  ON *.* TO 'debezium' IDENTIFIED BY 'dbz';

# Create the database that we'll use to populate data and watch the effect in the binlog
CREATE DATABASE demo;
GRANT ALL PRIVILEGES ON demo.* TO 'mysqluser'@'%';

use demo;

create table customers (
        id INT PRIMARY KEY,
        first_name VARCHAR(255),
        last_name VARCHAR(255),
        email VARCHAR(255),
        created_at DATETIME(3)
);

create table cities (
        id INT PRIMARY KEY,
        name VARCHAR(255),
        country VARCHAR(255),
        created_at DATETIME(3)

);

# __op VARCHAR(50),
# __deleted VARCHAR(50)
