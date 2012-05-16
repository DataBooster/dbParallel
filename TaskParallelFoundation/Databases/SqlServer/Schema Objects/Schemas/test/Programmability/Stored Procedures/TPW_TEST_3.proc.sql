CREATE PROCEDURE test.TPW_TEST_3
AS
	DECLARE	@tPJob_ID			INT;
	DECLARE	@tSQL				NVARCHAR(256);
	DECLARE @tScheduled_Time	DATETIME;
	DECLARE @tCancelled			BIT;
	
	EXEC client.TPW_CALL_CREATE_PJOB @tPJob_ID OUTPUT, N'App3', N'User3', N'This is test3.';

	EXEC xp_sprintf @tSQL OUTPUT, N'WAITFOR DELAY ''%s''', '00:00:10';
	EXEC client.TPW_CALL_ADD_TASK @tPJob_ID, @tSQL, 60, N'Task1 sleep for 10 seconds.';
	
	EXEC xp_sprintf @tSQL OUTPUT, N'WAITFOR DELAY ''%s''', '00:00:20';
	EXEC client.TPW_CALL_ADD_TASK @tPJob_ID, @tSQL, 60, N'Task2 sleep for 20 seconds.';

	EXEC xp_sprintf @tSQL OUTPUT, N'WAITFOR DELAY ''%s''', '00:00:30';
	EXEC client.TPW_CALL_ADD_TASK @tPJob_ID, @tSQL, 60, N'Task3 sleep for 30 seconds.';

	EXEC xp_sprintf @tSQL OUTPUT, N'WAITFOR DELAY ''%s''', '00:00:15';
	EXEC client.TPW_CALL_ADD_CALLBACK_FOR_SUCCESS @tPJob_ID, @tSQL, 180, N'Sleep for 15s if all success.';

	SET @tScheduled_Time = DATEADD(hour, 1, GETDATE());
	EXEC client.TPW_CALL_START_PJOB @tPJob_ID, @tScheduled_Time;

	WAITFOR DELAY '00:00:10';

	EXEC client.TPW_CALL_TRY_CANCEL_PJOB @tPJob_ID, @tCancelled OUTPUT;

	IF @tCancelled = 1
		SET @tSQL = N' has';
	ELSE
		SET @tSQL = N' cannot';

	SELECT N'PJob_ID#' + CAST(@tPJob_ID AS NVARCHAR(64)) + @tSQL + N' been canceled.' AS HAS_CANCEL;
