#!/usr/bin/env bash

echo "Load inventory.sql to SQL Server"
cat db/inventory.sql | docker exec -i sqlserver bash -c '/opt/mssql-tools/bin/sqlcmd -U sa -P Password!'
