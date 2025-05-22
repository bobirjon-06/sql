DROP TABLE IF EXISTS #Results;

CREATE TABLE #Results (
    DatabaseName SYSNAME,
    SchemaName SYSNAME,
    TableName SYSNAME,
    ColumnName SYSNAME,
    DataType SYSNAME
);

DECLARE @sql NVARCHAR(MAX) = N'';
SELECT @sql += '
USE [' + name + '];
INSERT INTO #Results
SELECT 
    ''' + name + ''' AS DatabaseName,
    s.name AS SchemaName,
    t.name AS TableName,
    c.name AS ColumnName,
    ty.name AS DataType
FROM 
    sys.schemas s
    JOIN sys.tables t ON t.schema_id = s.schema_id
    JOIN sys.columns c ON c.object_id = t.object_id
    JOIN sys.types ty ON c.user_type_id = ty.user_type_id
WHERE 
    t.is_ms_shipped = 0;
'
FROM sys.databases
WHERE name NOT IN ('master', 'tempdb', 'model', 'msdb');

EXEC sp_executesql @sql;
SELECT * FROM #Results
ORDER BY DatabaseName, SchemaName, TableName, ColumnName;
