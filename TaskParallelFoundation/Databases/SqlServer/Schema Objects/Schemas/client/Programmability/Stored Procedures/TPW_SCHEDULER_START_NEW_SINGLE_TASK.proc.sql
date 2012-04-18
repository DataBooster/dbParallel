CREATE PROCEDURE client.TPW_SCHEDULER_START_NEW_SINGLE_TASK
(
	@inDynamic_SQL		NVARCHAR(MAX),
	@inCommand_Timeout	TINYINT			= 10,
	@inSuccess_Callback	NVARCHAR(MAX)	= NULL,
	@inFail_Callback	NVARCHAR(MAX)	= NULL,
	@inUser_App			NVARCHAR(128)	= N'',
	@inUser_Name		NVARCHAR(64)	= N'',
	@inDescription		NVARCHAR(256)	= N''
)
AS
	SET NOCOUNT ON;
	DECLARE	@tPJob_ID	INT;
	DECLARE	@tReturn	INT;

	EXEC client.TPW_SCHEDULER_CREATE_PJOB @tPJob_ID OUTPUT, @inUser_App, @inUser_Name, @inDescription;

	EXEC @tReturn = client.TPW_SCHEDULER_ADD_TASK @tPJob_ID, @inDynamic_SQL, @inCommand_Timeout;

	IF @tReturn < 0
		RETURN @tReturn;

	IF @inSuccess_Callback IS NOT NULL
		EXEC client.TPW_SCHEDULER_ADD_CALLBACK_FOR_SUCCESS @tPJob_ID, @inSuccess_Callback, @inCommand_Timeout;

	IF @inFail_Callback IS NOT NULL
		EXEC client.TPW_SCHEDULER_ADD_CALLBACK_FOR_FAIL @tPJob_ID, @inFail_Callback, 3, @inCommand_Timeout;

	EXEC @tReturn = client.TPW_SCHEDULER_START_PJOB @tPJob_ID;

	RETURN @tReturn;
