USE [DBA_Works]
GO

/****** Object:  StoredProcedure [dbo].[QueryRunning]    Script Date: 12/10/2018 12:10:04 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[QueryRunning]
/****
	Description: Shows what is being executed right now.
	Test: Execute dbo.QueryRunning
****/
AS 
BEGIN

SELECT      r.start_time [Start Time],session_ID [SPID],
            DB_NAME(database_id) [Database],
            SUBSTRING(t.text,(r.statement_start_offset/2)+1,
            CASE WHEN statement_end_offset=-1 OR statement_end_offset=0 
            THEN (DATALENGTH(t.Text)-r.statement_start_offset/2)+1 
            ELSE (r.statement_end_offset-r.statement_start_offset)/2+1
            END) [Executing SQL], 
            Status,command,wait_type,wait_time,wait_resource, 
            last_wait_type
FROM        sys.dm_exec_requests r
OUTER APPLY sys.dm_exec_sql_text(sql_handle) t
WHERE       session_id != @@SPID -- don't show this query
AND         session_id > 50 -- don't show system queries
ORDER BY    r.start_time

SET NOCOUNT OFF
END 
GO

