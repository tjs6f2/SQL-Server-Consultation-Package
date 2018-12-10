# SQL Server Consultation Package

Host for stored procedures and documentation

#### Stored Procedure Description 

ActiveOnInstance: Displays all current logged into the database

AgentJobSchedule: Displays all jobs that are on the instance. Shows if they are enabled and when it was created

AuthenticationMode: Displays what authentication mode is currently being used

CompareRowCount: Displays the row count of each table in the database specified.

CountConnections: Returns a count of open connections including background items

ExecutionCount: Returns number of times each stored procedure was executed in a particular database

FindOrphans: Returns users that are not currently mapped to a login 

GetBackupHistory: Allows user to see all backups taken to a point in time

LastQueries: Returns all queries that have been executed in the current session

MemoryUseage: Shows a breakdown of memory usage (RAM) by group 

QueryRunning: Displays all queries that are currently being executed on the instance at that time

RemainingDiskSpace: Shows the amount of hard drive space that is remaining on the instance

ShowLogReport: Returns all of the transaction logs and their description on the instance

ValidateBackups: Allows user to validate backup to check for corruption

ViewPermissions: Displays users and their permissions on each database

#### How to implement:

1.	Follow link to host: https://github.com/tjs6f2/SQL-Server-Consultation-Package
2.	Download scripts you want on instance
3.	Open script in SSMS and select which database you want to keep the script
4.	Execute stored procedure

#### Rollback: 
1.	DROP PROCEDURE <stored procedure name>;  
