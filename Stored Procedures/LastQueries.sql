USE [DBA_Works] -- enter database location for stored procedure
GO

/****** Object:  StoredProcedure [dbo].[LastQueries]    Script Date: 12/9/2018 11:52:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[LastQueries]
/***
	Description: Returns all queries that have been executed in the current session

	Test: Execute dbo.LastQueries
***/

AS 
BEGIN

SELECT text AS Last_Queries FROM sys.dm_exec_sessions es
  INNER JOIN sys.dm_exec_connections ec
      ON es.session_id = ec.session_id
  CROSS APPLY sys.dm_exec_sql_text(ec.most_recent_sql_handle) 
  where program_name like '%Query'

  SET NOCOUNT OFF
END 
GO

