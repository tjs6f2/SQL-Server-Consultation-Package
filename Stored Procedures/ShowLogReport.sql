USE [DBA_Works] -- enter database location for stored procedure
GO

/****** Object:  StoredProcedure [dbo].[ShowLogReport]    Script Date: 12/10/2018 12:20:42 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[ShowLogReport]
/*****
		Decription: Returns all of the transaction logs and their description on the instance

		Test: EXEC dbo.ShowLogReport
*****/
AS 
BEGIN


CREATE TABLE #TempErrorLogs
(
	[LogDate] DATETIME 
	,[ProcessInfo] VARCHAR(50)
	,[Text] VARCHAR(MAX)
) 
 
INSERT INTO #TempErrorLogs 
([LogDate], [ProcessInfo], [Text])
EXEC [master].[dbo].[xp_readerrorlog] 0 

SELECT * FROM #TempErrorLogs

DROP TABLE #TempErrorLogs

SET NOCOUNT OFF
END 
GO

