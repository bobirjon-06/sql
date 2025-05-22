CREATE PROCEDURE GetProceduresAndFunctions

AS
BEGIN
    SET NOCOUNT ON;
	DROP TABLE if exists #ProcFuncInfo;

    CREATE TABLE #ProcFuncInfo (
        DatabaseName SYSNAME,
        SchemaName SYSNAME,
        ObjectName SYSNAME,
        ObjectType NVARCHAR(60),
        ParameterName SYSNAME,
        DataType NVARCHAR(128),
        MaxLength INT
    );

    DECLARE @sql NVARCHAR(MAX) = N'';

    IF @DatabaseName IS NOT NULL
    BEGIN
        SET @sql = '
        USE [' + @DatabaseName + '];

        INSERT INTO #ProcFuncInfo
        SELECT
            ''' + @DatabaseName + ''' AS DatabaseName,
            s.name AS SchemaName,
            o.name AS ObjectName,
            o.type_desc AS ObjectType,
            p.name AS ParameterName,
            t.name AS DataType,
            p.max_length AS MaxLength
        FROM sys.objects o
        JOIN sys.schemas s ON o.schema_id = s.schema_id
        LEFT JOIN sys.types t ON p.user_type_id = t.user_type_id
        WHERE o.type IN (''P'', ''FN'', ''TF'', ''IF''); -- P=Proc, FN=Scalar, TF=Table-valued, IF=Inline
        ';
        EXEC sp_executesql @sql;
    END
    ELSE
    
        SELECT @sql = @sql + '
        USE [' + name + '];

        INSERT INTO #ProcFuncInfo
        SELECT
            ''' + name + ''' AS DatabaseName,
            s.name AS SchemaName,
            o.name AS ObjectName,
            o.type_desc AS ObjectType,
            p.name AS ParameterName,
            t.name AS DataType,
            p.max_length AS MaxLength
        FROM sys.objects o
        JOIN sys.schemas s ON o.schema_id = s.schema_id
        LEFT JOIN sys.parameters p ON o.object_id = p.object_id
        LEFT JOIN sys.types t ON p.user_type_id = t.user_type_id
        WHERE o.type IN (''P'', ''FN'', ''TF'', ''IF'');
        '
        FROM sys.databases
        WHERE name NOT IN ('master', 'model', 'msdb', 'tempdb');

        EXEC sp_executesql @sql;
    END

    SELECT * FROM #ProcFuncInfo
    ORDER BY DatabaseName, SchemaName, ObjectName, ParameterName;
END
