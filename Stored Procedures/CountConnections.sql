USE [DBA_Works] -- enter database location for stored procedure
GO

/****** Object:  StoredProcedure [dbo].[CountConnections]    Script Date: 12/9/2018 11:33:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[CountConnections]
/****
	Description: Returns a count of open connections including background items
	Test: Execute dbo.CountConnections
****/
AS
	BEGIN

	select a.dbid,b.name, count(a.dbid) as TotalConnections
		from sys.sysprocesses a
		inner join sys.databases b on a.dbid = b.database_id
	group by a.dbid, b.name

	/*EXEC sp_who2 'Active'*/

	SET NOCOUNT OFF
	END
GO

