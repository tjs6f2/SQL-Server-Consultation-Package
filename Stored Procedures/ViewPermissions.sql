USE [DBA_Works]
GO

/****** Object:  StoredProcedure [dbo].[ViewPermissions]    Script Date: 12/10/2018 12:22:13 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ViewPermissions] 

/******
		Decritpion: Displays users and their permissions on each database

		Test: EXEC dbo.ViewPermissions
******/

AS 
BEGIN

/****
		DECLARE @public AS VARCHAR(MAX) 
		SET @public = 'public'
	****/	
		DECLARE @DatabaseName AS VARCHAR(MAX)

		DECLARE DBNameCursor CURSOR
		FOR 
		SELECT NAME
		FROM sys.databases
		WHERE database_id > 4

		OPEN DBNameCursor

		FETCH NEXT
		FROM DBNameCursor
		INTO @DatabaseName

		WHILE @@FETCH_STATUS = 0 
		BEGIN
			DECLARE @DBName AS NVARCHAR(MAX)

			SET @DBName = QUOTENAME(N'' + @DatabaseName + '');

		EXEC (
			
			N'USE' + @DBName + N'; EXEC(''   

select  DB_NAME() AS DatabaseName
,		princ.name
,       princ.type_desc
,       perm.permission_name
,       perm.state_desc
,       perm.class_desc
from    sys.database_principals princ
left join 
         sys.database_permissions perm
on      perm.grantee_principal_id = princ.principal_id
'');'

			);

			FETCH NEXT 
			FROM DBNameCursor
			INTO @DatabaseName
		END

		CLOSE DBNameCursor

		DEALLOCATE DBNameCursor

	
END 
GO

