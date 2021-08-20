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
  email VARCHAR(255) NOT NULL UNIQUE
);

INSERT INTO customers(first_name,last_name,email)
  VALUES ('Sally','Thomas','sally.thomas@acme.com');
INSERT INTO customers(first_name,last_name,email)
  VALUES ('George','Bailey','gbailey@foobar.com');
INSERT INTO customers(first_name,last_name,email)
  VALUES ('Edward','Walker','ed@walker.com');
INSERT INTO customers(first_name,last_name,email)
  VALUES ('Anne','Kretchmar','annek@noanswer.org');

CREATE TABLE cities (
    id INTEGER IDENTITY(1001,1) NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    country VARCHAR(255) NOT NULL
);

INSERT INTO cities(name,country) VALUES ('Berlin', 'Germany');
INSERT INTO cities(name,country) VALUES ('Leipzig', 'Germany');
INSERT INTO cities(name,country) VALUES ('Hamburg', 'Germany');
INSERT INTO cities(name,country) VALUES ('Barcelona', 'Spain');
INSERT INTO cities(name,country) VALUES ('Girona', 'Spain');



EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'customers', @role_name = NULL, @supports_net_changes = 0;
EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'cities', @role_name = NULL, @supports_net_changes = 0;
GO
