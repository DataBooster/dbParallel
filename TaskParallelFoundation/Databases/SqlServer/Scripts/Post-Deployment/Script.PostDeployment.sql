/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

:r .\1-TPW_PUMP_CONFIG.sql
:r .\2-TPW_WF_ACTIVITY.sql
:r .\3-TPW_WF_STATE.sql
:r .\4-TPW_WF_ACTIVITY.sql
:r .\5-TPW_WF_EVENT.sql
:r .\6-TPW_WF_STATE_MACHINE.sql
