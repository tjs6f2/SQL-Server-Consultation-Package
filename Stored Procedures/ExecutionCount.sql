USE [DBA_Works] -- enter database location for stored procedure
GO

/****** Object:  StoredProcedure [dbo].[ExecutionCount]    Script Date: 12/9/2018 11:36:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[ExecutionCount]
	@DatabaseName varchar(max)
/****
	Description: Returns number of times each stored procedure was executed in a particular database
	Test: Execute dbo.executionCount 'DBA_Works'
****/

AS
BEGIN

SELECT
DatabaseName = DB_NAME(st.dbid)
,SchemaName = OBJECT_SCHEMA_NAME(st.objectid,dbid)
,StoredProcedure	= OBJECT_NAME(st.objectid,dbid)
,ExecutionCount = MAX(cp.usecounts)
FROM sys.dm_exec_cached_plans cp
CROSS APPLY sys.dm_exec_sql_text(cp.plan_handle) st
WHERE DB_NAME(st.dbid) IS NOT NULL
AND cp.objtype = 'proc'
and DB_NAME(st.dbid) = @DatabaseName 
GROUP BY
cp.plan_handle
,DB_NAME(st.dbid)
,OBJECT_SCHEMA_NAME(objectid,st.dbid)
,OBJECT_NAME(objectid,st.dbid)
ORDER BY MAX(cp.usecounts) DESC

SET NOCOUNT OFF
END
GO

