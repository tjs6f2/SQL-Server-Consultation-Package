USE [DBA_Works] -- enter database location for stored procedure
GO

/****** Object:  StoredProcedure [dbo].[CompareRowCount]    Script Date: 12/10/2018 9:01:16 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[CompareRowCount] (@dbname VARCHAR(MAX))

/******
		Description: Displays the row count of each table in the database specified.

		Test: EXEC dbo.CompareRowCount 'DataBaseName'
		ex: EXEC dbo.CompareRowCount 'BaseballData'
*****/

AS
 BEGIN

  EXEC		('USE ['+ @dbname +'];
  SELECT	T.name TableName, i.Rows NumberOfRows
  FROM		sys.tables T
  JOIN		sys.sysindexes I on T.Object_ID = I.ID
  WHERE		indid IN (0,1)
  ORDER BY	i.Rows DESC, T.name ')

  SET NOCOUNT OFF
 END
GO

