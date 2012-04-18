CREATE PROCEDURE test.TPW_TEST_1
AS
	DECLARE	@tPJob_ID	INT;
	DECLARE	@tSQL		NVARCHAR(256);
	
	EXEC client.TPW_SCHEDULER_CREATE_PJOB @tPJob_ID OUTPUT, N'Test1', N'Tester1', N'This is test1.';


	EXEC xp_sprintf @tSQL OUTPUT, N'WAITFOR DELAY ''%s''', '00:00:10';
	EXEC client.TPW_SCHEDULER_ADD_TASK @tPJob_ID, @tSQL, 1, N'Sleep for a while.';
	
	EXEC xp_sprintf @tSQL OUTPUT, N'WAITFOR DELAY ''%s''', '00:01:10';
	EXEC client.TPW_SCHEDULER_ADD_TASK @tPJob_ID, @tSQL, 1, N'Sleep for a while.';

	EXEC xp_sprintf @tSQL OUTPUT, N'WAITFOR DELAY ''%s''', '00:00:30';
	EXEC client.TPW_SCHEDULER_ADD_TASK @tPJob_ID, @tSQL, 1, N'Sleep for a while.';

	EXEC xp_sprintf @tSQL OUTPUT, N'WAITFOR DELAY ''%s''', '00:01:10';
	EXEC client.TPW_SCHEDULER_ADD_TASK @tPJob_ID, @tSQL, 2, N'Sleep for a while.';

	EXEC xp_sprintf @tSQL OUTPUT, N'WAITFOR DELAY ''%s''', '00:00:15';
	EXEC client.TPW_SCHEDULER_ADD_CALLBACK_FOR_SUCCESS @tPJob_ID, @tSQL, 3, N'Sleep for a while if success.';

	EXEC xp_sprintf @tSQL OUTPUT, N'WAITFOR DELAY ''%s''', '00:00:25';
	EXEC client.TPW_SCHEDULER_ADD_CALLBACK_FOR_FAIL @tPJob_ID, @tSQL, 3, N'Sleep for a while if fail.';


	EXEC client.TPW_SCHEDULER_START_PJOB @tPJob_ID;

	SELECT N'New PJob_ID#' + CAST(@tPJob_ID AS NVARCHAR(64)) AS NEW_PJOB_ID;
