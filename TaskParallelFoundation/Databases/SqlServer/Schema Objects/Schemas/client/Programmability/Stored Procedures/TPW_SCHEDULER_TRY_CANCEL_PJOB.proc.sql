CREATE PROCEDURE client.TPW_SCHEDULER_TRY_CANCEL_PJOB
(
	@inPJob_ID		INT,
	@outCancelled	BIT	OUTPUT
)
AS
	SET NOCOUNT ON;
	DECLARE	@tReturn	INT;

	EXEC @tReturn = dbo.TPW_SERVICE_ON_PJOB_EVENT @inPJob_ID, N'CANCEL';

	IF @tReturn < 0
		SET	@outCancelled = 0;
	ELSE
		SET	@outCancelled = 1;

	RETURN @tReturn;
