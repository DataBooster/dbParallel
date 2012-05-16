CREATE PROCEDURE test.TPW_TEST_4
AS
	DECLARE	@tPJob_ID	INT;
	DECLARE	@tSQL		NVARCHAR(256);
	
	EXEC client.TPW_CALL_CREATE_PJOB @tPJob_ID OUTPUT, N'App4', N'User4', N'This is test4.';


	EXEC xp_sprintf @tSQL OUTPUT, N'WAITFOR DELAY ''%s''', '00:00:10';
	EXEC client.TPW_CALL_ADD_TASK @tPJob_ID, @tSQL, 60, N'Task1 sleep for 10 seconds.';
	
	EXEC xp_sprintf @tSQL OUTPUT, N'WAITFOR DELAY ''%s''', '00:00:20';
	EXEC client.TPW_CALL_ADD_TASK @tPJob_ID, @tSQL, 60, N'Task2 sleep for 20 seconds.';

	EXEC xp_sprintf @tSQL OUTPUT, N'WAITFOR DELAY ''%s''', '00:00:30';
	EXEC client.TPW_CALL_ADD_TASK @tPJob_ID, @tSQL, 60, N'Task3 sleep for 30 seconds.';

	EXEC xp_sprintf @tSQL OUTPUT, N'WAITFOR DELAY ''%s''', '00:01:10';
	EXEC client.TPW_CALL_ADD_TASK @tPJob_ID, @tSQL, 120, N'Task4 sleep for 70 seconds.';

	EXEC xp_sprintf @tSQL OUTPUT, N'WAITFOR DELAY ''%s''', '00:00:15';
	EXEC client.TPW_CALL_ADD_CALLBACK_FOR_SUCCESS @tPJob_ID, @tSQL, 180, N'Sleep for 15s if all success.';

	EXEC xp_sprintf @tSQL OUTPUT, N'WAITFOR DELAY ''%s''', '00:00:25';
	EXEC client.TPW_CALL_ADD_CALLBACK_FOR_FAIL @tPJob_ID, @tSQL, 180, N'Sleep for 25s if fail.';


	EXEC client.TPW_CALL_START_PJOB @tPJob_ID;

	SELECT N'New PJob_ID#' + CAST(@tPJob_ID AS NVARCHAR(64)) AS NEW_PJOB_ID;
