USE [DBA_Works] -- enter database location for stored procedure
GO

/****** Object:  StoredProcedure [dbo].[RemainingDiskSpace]    Script Date: 12/10/2018 12:16:13 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[RemainingDiskSpace]
/****
	Description: Shows the amount of hard drive space that is remaining on the instance

	Test: Execute dbo.RemainingDiskSpace
****/
AS
BEGIN

Create Table #dbInfo (dbName sysname,   
       fileLocation varchar(520) NULL, 
	   sizeMb decimal(10,2) null, 
       usedMb decimal(10,2) null, 
	   freeMb decimal(10,2) null, 
       percentUsed decimal(10,2) null, 
	   percentFree decimal(10,2) null
)

Declare @sSql varchar(1000)

Set @sSql = 'Use [?];
Insert #dbInfo (dbName, 
		fileLocation, 
		sizeMb, 
		usedMb)

Select db_name(), 
		filename, 
		Cast(size/128.0 As Decimal(10,2)), 
		Cast(Fileproperty(name, ''SpaceUsed'')/128.0 As Decimal(10,2))
From dbo.sysfiles Order By groupId Desc;'

Exec sp_MSforeachdb @sSql

Update #dbInfo Set
freeMb = sizeMb - usedMb,
percentUsed = (usedMb/sizeMb)*100,
percentFree = ((sizeMb-usedMb)/sizeMb)*100

select * from #dbInfo

drop table #dbInfo

SET NOCOUNT OFF
END
GO

