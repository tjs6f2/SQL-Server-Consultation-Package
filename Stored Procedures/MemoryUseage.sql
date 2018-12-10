USE [DBA_Works] -- enter database location for stored procedure
GO

/****** Object:  StoredProcedure [dbo].[MemoryUseage]    Script Date: 12/10/2018 12:08:58 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[MemoryUseage]
/***
	Description: shows a breakdown of memory useage by group
	Test: Execute dbo.MemoryUseage
***/
AS
	BEGIN

	SELECT  
	(physical_memory_in_use_kb/1024) AS Memory_usedby_Sqlserver_MB,  
	(locked_page_allocations_kb/1024) AS Locked_pages_used_Sqlserver_MB,  
	(total_virtual_address_space_kb/1024) AS Total_VAS_in_MB,  
	process_physical_memory_low,  
	process_virtual_memory_low  
	FROM sys.dm_os_process_memory;  

	SET NOCOUNT OFF
	END
GO

