CREATE PROCEDURE client.TPW_SCHEDULER_ADD_CALLBACK_FOR_SUCCESS
(
	@inPJob_ID			INT,
	@inDynamic_SQL_STMT	NVARCHAR(MAX),
	@inCommand_Timeout	TINYINT			= 10,
	@inDescription		NVARCHAR(256)	= N''
)
AS
	SET NOCOUNT ON;
	DECLARE	@tReturn	INT;

	EXEC @tReturn = dbo.TPW_SERVICE_ADD_TASK @inPJob_ID, 0, @inDynamic_SQL_STMT, @inCommand_Timeout, @inDescription;

	RETURN @tReturn;
