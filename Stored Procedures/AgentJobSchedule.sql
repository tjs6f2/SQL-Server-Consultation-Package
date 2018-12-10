USE [DBA_Works] -- enter database location for stored procedure
GO

/****** Object:  StoredProcedure [dbo].[AgentJobSchedule]    Script Date: 12/9/2018 10:43:26 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[AgentJobSchedule]
/*****
		Decription: Displays all jobs that are on the instance. Shows if they are enabled
					and when it was created

		Test: EXEC dbo.AgentJobSchedule
*****/

AS 
BEGIN

SELECT 
	SJ.name AS JobName
	,CASE
		WHEN SJ.enabled = 1 THEN 'Enable'
	ELSE 'Disable'
	END AS JobStatus
	,SJ.description AS JobDescription
	,SS.name AS JobScheduleName
	,CASE
		WHEN SS.enabled = 1 THEN 'Enable'
		WHEN SS.enabled = 0 THEN 'Disable'
	ELSE 'Not Schedule'
	END AS JobScheduleStatus
	,SS.active_start_date AS ActiveStartDate
	,SS.active_end_date AS ActiveEndDate
FROM MSDB.dbo.sysjobs AS SJ
LEFT JOIN MSDB.dbo.sysjobschedules AS SJS
        ON SJ.job_id = SJS.job_id
LEFT JOIN MSDB.dbo.sysschedules AS SS
        ON SJS.schedule_id = SS.schedule_id
WHERE SS.name is not null

SET NOCOUNT OFF
END
GO

