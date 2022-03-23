-- Create the test database
CREATE DATABASE testDB;
GO
USE testDB;
EXEC sys.sp_cdc_enable_db;

-- Create some customers ...
CREATE TABLE customers (
  id INTEGER IDENTITY(1001,1) NOT NULL PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  created_at DATETIME2(7) NOT NULL
);

INSERT INTO customers(first_name,last_name,email,created_at)
  VALUES ('Sally','Thomas','sally.thomas@acme.com',SYSDATETIME());
INSERT INTO customers(first_name,last_name,email,created_at)
  VALUES ('George','Bailey','gbailey@foobar.com',SYSDATETIME());
INSERT INTO customers(first_name,last_name,email,created_at)
  VALUES ('Edward','Walker','ed@walker.com',SYSDATETIME());
INSERT INTO customers(first_name,last_name,email,created_at)
  VALUES ('Anne','Kretchmar','annek@noanswer.org',SYSDATETIME());

CREATE TABLE cities (
    id INTEGER IDENTITY(1001,1) NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    country VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL
);

INSERT INTO cities(name,country, created_at) VALUES ('Berlin', 'Germany', GETDATE());
INSERT INTO cities(name,country, created_at) VALUES ('Leipzig', 'Germany', GETDATE());
INSERT INTO cities(name,country, created_at) VALUES ('Hamburg', 'Germany', GETDATE());
INSERT INTO cities(name,country, created_at) VALUES ('Barcelona', 'Spain', GETDATE());
INSERT INTO cities(name,country, created_at) VALUES ('Girona', 'Spain', GETDATE());


CREATE TABLE debezium_signal (id VARCHAR(42) PRIMARY KEY, type VARCHAR(32) NOT NULL, data VARCHAR(2048) NULL);

EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'customers', @role_name = NULL, @supports_net_changes = 0;
EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'cities', @role_name = NULL, @supports_net_changes = 0;
GO
