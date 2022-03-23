docker exec -i sqlserver /opt/mssql-tools/bin/sqlcmd -U sa -P Password! << EOF
USE testDB;
INSERT INTO customers(first_name,last_name,email,created_at) VALUES ('Luk','Skywalker','luk@office.com',SYSDATETIME());
GO
EOF
