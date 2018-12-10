USE [DBA_Works] -- enter database location for stored procedure
GO

/****** Object:  StoredProcedure [dbo].[ActiveOnInstance]    Script Date: 12/9/2018 10:34:55 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ActiveOnInstance]

/*****
		Decription: Displays all current logged into the database

		Test: EXEC dbo.ActiveOnInstance
****/

AS 
BEGIN

  
select db, usr as userName from
( select sp.loginame as usr, sd.name as db
from sysprocesses sp join sysdatabases sd on sp.dbid = sd.dbid ) as db_usage
where db like('%')
group by db, usr
order by db, usr


SET NOCOUNT OFF
END 
GO

