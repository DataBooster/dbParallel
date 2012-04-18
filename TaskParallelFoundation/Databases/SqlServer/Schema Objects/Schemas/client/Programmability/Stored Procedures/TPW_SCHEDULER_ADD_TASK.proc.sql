CREATE PROCEDURE client.TPW_SCHEDULER_ADD_TASK
(
	@inPJob_ID			INT,
	@inDynamic_SQL_STMT	NVARCHAR(MAX),
	@inCommand_Timeout	TINYINT			= 10,
	@inDescription		NVARCHAR(256)	= N''
)
AS
	SET NOCOUNT ON;
	DECLARE	@tReturn	INT;
	DECLARE	@tTask_ID	SMALLINT;

	EXEC dbo.TPW_SERVICE_NEXT_TASK_ID @inPJob_ID, @tTask_ID OUTPUT;

	EXEC @tReturn = dbo.TPW_SERVICE_ADD_TASK @inPJob_ID, @tTask_ID, @inDynamic_SQL_STMT, @inCommand_Timeout, @inDescription;

	RETURN @tReturn;
