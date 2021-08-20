docker exec -i sqlserver /opt/mssql-tools/bin/sqlcmd -U sa -P Password! << EOF
USE testDB;
DELETE from customers where id = 1005;
GO
EOF
