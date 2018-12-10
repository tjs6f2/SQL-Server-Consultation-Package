USE [DBA_Works] -- enter database location for stored procedure
GO

/****** Object:  StoredProcedure [dbo].[ValidateBackups]    Script Date: 12/10/2018 12:21:51 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ValidateBackups] (@backupFilePath varchar(max))

/*****

	Description: Allows user to validate backup to check for corruption

	Test: EXEC dbo.ValidateBackups 'C:\Program Files\Microsoft SQL Server\Backups\capstone4970\AdventureWorksDW2017\DIFF\capstone4970_AdventureWorksDW2017_DIFF_20181022_120001.bak'

*****/

AS
 BEGIN
  DECLARE @tsql varchar(max)
  
  SET NOCOUNT ON
  SET @tsql = 'RESTORE VERIFYONLY FROM DISK = ' + '''' +  @backupFilePath + '''' + ' WITH CHECKSUM'

  EXEC (@tsql)
  
  SET NOCOUNT OFF
 END
GO

