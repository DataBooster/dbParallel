CREATE PROCEDURE dbo.TPW_SERVICE_CALLBACK_TASK
(
	@inPJob_ID			INT,
	@inTask_ID			SMALLINT
)
AS
	SET NOCOUNT ON;
	DECLARE	@tReturn	INT;

	EXEC @tReturn = TPW_SERVICE_ON_PJOB_EVENT @inPJob_ID, N'CALLBACK';
	IF @tReturn < 0
		RETURN @tReturn;

	EXEC @tReturn = TPW_SERVICE_RUN_TASK @inPJob_ID, @inTask_ID;

	RETURN @tReturn;