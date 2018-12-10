USE [DBA_Works] -- enter database location for stored procedure
GO

/****** Object:  StoredProcedure [dbo].[FindOrphans]    Script Date: 12/9/2018 11:41:44 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[FindOrphans]
/****
	Description: Returns users that are not currently mapped to a login 

	Test: Execute dbo.FindOrphans
****/

AS
SET NOCOUNT ON;

Create Table #Orphans 
 (
  RowID     int not null primary key identity(1,1) ,
  TDBName varchar (100),
  UserName varchar (100),
  UserSid varbinary(85)
 )
SET NOCOUNT ON 
 DECLARE @DBName sysname, @Qry nvarchar(4000)
 SET @Qry = ''
 SET @DBName = ''
 WHILE @DBName IS NOT NULL
 BEGIN
   SET @DBName = 
     (
  SELECT MIN(name) 
   FROM master..sysdatabases 
   WHERE
   /** to exclude named databases add them to the Not In clause **/
   name NOT IN 
     (
      'model', 'msdb', 
      'distribution'
     ) And 
     DATABASEPROPERTY(name, 'IsOffline') = 0 
     AND DATABASEPROPERTY(name, 'IsSuspect') = 0 
     AND name > @DBName
      )
   IF @DBName IS NULL BREAK
         
                Set @Qry = 'select ''' + @DBName + ''' as DBName, name AS UserName, 
                sid AS UserSID from [' + @DBName + ']..sysusers 
                where issqluser = 1 and (sid is not null and sid <> 0x0) 
                and suser_sname(sid) is null order by name'
 Insert into #Orphans Exec (@Qry)
 
 End
Select * from #Orphans

Drop table #Orphans

GO

