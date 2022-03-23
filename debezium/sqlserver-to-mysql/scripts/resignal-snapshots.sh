docker exec -i sqlserver /opt/mssql-tools/bin/sqlcmd -U sa -P Password! << EOF
USE testDB;
INSERT INTO debezium_signal VALUES('ad-hoc-2', 'execute-snapshot', '{"data-collections": ["dbo.customers"]}');
GO
EOF
