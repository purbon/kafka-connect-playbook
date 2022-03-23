docker exec -i sqlserver /opt/mssql-tools/bin/sqlcmd -U sa -P Password! << EOF
USE testDB;
DELETE from cities where id = 1004;
GO
EOF
