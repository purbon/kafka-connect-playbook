
-- Discover which tables have CDC enabled --

SELECT s.name AS Schema_Name, tb.name AS Table_Name
, tb.object_id, tb.type, tb.type_desc, tb.is_tracked_by_cdc
FROM sys.tables tb
INNER JOIN sys.schemas s on s.schema_id = tb.schema_id
WHERE tb.is_tracked_by_cdc = 1


--- check if agent is running ---

IF EXISTS (  SELECT 1
             FROM master.dbo.sysprocesses
             WHERE program_name = N'SQLAgent - Generic Refresher')
BEGIN
    SELECT @@SERVERNAME AS 'InstanceName', 1 AS 'SQLServerAgentRunning'
END
ELSE
BEGIN
    SELECT @@SERVERNAME AS 'InstanceName', 0 AS 'SQLServerAgentRunning'
END


-- check CDC is enabled -->

SELECT *
FROM sys.change_tracking_databases
WHERE database_id=DB_ID('MyDatabase')
And check if is running:

EXECUTE sys.sp_cdc_enable_db;
GO

--- Your CDC service are running on SQL Server? See in docs --
EXEC sys.sp_cdc_start_job;
GO


-- On enabling table in CDC, I had some issues with rolename. --
EXEC sys.sp_cdc_enable_table
        @source_schema=N'dbo',
        @source_name=N'AD6010',
        @capture_instance=N'ZZZZ_AD6010',
        @role_name = NULL,
        @filegroup_name=N'CDC_DATA',
        @supports_net_changes=1
GO
