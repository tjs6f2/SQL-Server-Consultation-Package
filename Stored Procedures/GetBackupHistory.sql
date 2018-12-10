USE [DBA_Works] -- enter database location for stored procedure
GO

/****** Object:  StoredProcedure [dbo].[GetBackupHistory]    Script Date: 12/9/2018 11:47:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetBackupHistory]
	@time INT

/*****
	Description: Allows user to see all backups taken to a point in time

	Test: Exec dbo.GetBackupHistory '5'
*****/

AS
SET NOCOUNT ON;

/*load data into a temp table for performance*/
CREATE TABLE #Results 
(
DatabaseName varchar(max),
Backup_Start DATETIME,
Backup_Finish DATETIME,
Backup_Type varchar(max),
Backup_Size_MB int,
Backup_Location varchar(max)
);

INSERT INTO #Results 
(
DatabaseName,
Backup_Start,
Backup_Finish,
Backup_Type,
Backup_Size_MB,
Backup_Location
)

SELECT msdb.dbo.backupset.database_name, 
msdb.dbo.backupset.backup_start_date, 
msdb.dbo.backupset.backup_finish_date, 
msdb..backupset.type, 
msdb.dbo.backupset.backup_size, 
msdb.dbo.backupmediafamily.physical_device_name

FROM msdb.dbo.backupmediafamily 

INNER JOIN msdb.dbo.backupset 
	ON msdb.dbo.backupmediafamily.media_set_id = msdb.dbo.backupset.media_set_id 

WHERE (msdb.dbo.backupset.backup_start_date >= GETDATE() - @time) 

SELECT * FROM #Results
ORDER BY
DatabaseName,
Backup_Finish;

DROP TABLE #Results;
GO

