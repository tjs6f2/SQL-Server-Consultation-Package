USE [DBA_Works] -- enter database location for stored procedure
GO

/****** Object:  StoredProcedure [dbo].[AuthenticationMode]    Script Date: 12/9/2018 11:28:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[AuthenticationMode]

/******
		Decritpion: Displays what authentication mode is currently being used

		Test: EXEC dbo.AuthenticationMode
******/

AS
	BEGIN

SELECT 
	CASE SERVERPROPERTY('IsIntegratedSecurityOnly')
	WHEN 0 THEN 'Mixed Mode - Authentication Mode (Both SQL Server and Windows Authentication)'
	WHEN 1 THEN 'Only Windows Authentication Mode.' 
END AS SQL_Server_Authentication_Mode


	SET NOCOUNT OFF
	END
GO

