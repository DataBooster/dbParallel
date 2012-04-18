CREATE PROCEDURE client.TPW_SCHEDULER_START_PJOB
(
	@inPJob_ID			INT,
	@inScheduled_Time	DATETIME	= NULL
)
AS
	SET NOCOUNT ON;

	IF @inScheduled_Time IS NULL
		SET	@inScheduled_Time = GETDATE();

	DECLARE	@tReturn		INT;
	DECLARE	@tExpiry_Time	DATETIME;

	SET	@tExpiry_Time	= DATEADD(day, dbo.TPW_SERVICE_GET_EXPIRY_DAY(), @inScheduled_Time);

	EXEC @tReturn = dbo.TPW_SERVICE_ON_PJOB_EVENT @inPJob_ID, N'START';
	IF @tReturn < 0
		RETURN @tReturn;

	UPDATE	TPW_PJOB
	SET
			SCHEDULED_TIME	= @inScheduled_Time,
			EXPIRY_TIME		= @tExpiry_Time
	WHERE
			PJOB_ID			= @inPJob_ID;
