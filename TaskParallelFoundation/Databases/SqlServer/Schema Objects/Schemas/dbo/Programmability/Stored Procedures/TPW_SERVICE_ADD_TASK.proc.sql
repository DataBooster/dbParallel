CREATE PROCEDURE dbo.TPW_SERVICE_ADD_TASK
(
	@inPJob_ID			INT,
	@inTask_ID			SMALLINT,
	@inDynamic_SQL_STMT	NVARCHAR(MAX),
	@inCommand_Timeout	TINYINT,
	@inDescription_		NVARCHAR(256)
)
AS
	SET NOCOUNT ON;
	DECLARE	@tReturn	INT;
	DECLARE	@tLog		BIT;

	IF @inCommand_Timeout < 1
		SET	@inCommand_Timeout = 1;

	IF @inTask_ID > 0
		SET	@tLog = 1;
	ELSE
		SET	@tLog = 0;

	EXEC @tReturn = TPW_SERVICE_ON_PJOB_EVENT @inPJob_ID, N'ADD_TASK', @tLog;
	IF @tReturn < 0
		RETURN	@tReturn;

	INSERT INTO TPW_TASK (PJOB_ID, TASK_ID, COMMAND_TIMEOUT, DYNAMIC_SQL_STMT, DESCRIPTION_)
	VALUES (@inPJob_ID, @inTask_ID, @inCommand_Timeout, @inDynamic_SQL_STMT, @inDescription_);
