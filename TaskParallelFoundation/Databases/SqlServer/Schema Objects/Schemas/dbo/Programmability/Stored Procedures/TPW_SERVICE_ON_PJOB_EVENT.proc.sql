CREATE PROCEDURE dbo.TPW_SERVICE_ON_PJOB_EVENT
(
	@inPJob_ID			INT,
	@inEvent_Name		NVARCHAR(32),
	@inCheck_State		BIT				= 1,	-- TRUE
	@inLog				BIT				= 1,	-- TRUE
	@inMessage			NVARCHAR(1024)	= NULL
)
AS
	SET NOCOUNT ON;
	DECLARE	@tReturn			INT;
	DECLARE	@tOld_State_ID		SMALLINT;
	DECLARE	@tEvent_ID			SMALLINT;
	DECLARE	@tNew_State_ID		SMALLINT;

	SELECT @tOld_State_ID = STATE_ID FROM TPW_PJOB WHERE PJOB_ID = @inPJob_ID;
	IF @tOld_State_ID IS NULL
		RETURN -110;

	EXEC @tReturn = TPW_SERVICE_WF_EVENT_HANDLER @tOld_State_ID, @tEvent_ID OUTPUT, @inEvent_Name, @tNew_State_ID OUTPUT, @inCheck_State;
	IF @tReturn < 0
		RETURN @tReturn;

	UPDATE	TPW_PJOB
	SET		STATE_ID		= @tNew_State_ID
	WHERE	STATE_ID		= @tOld_State_ID
		AND	PJOB_ID			= @inPJob_ID
		AND	@tNew_State_ID	!= @tOld_State_ID;

	IF	@inLog = 1
	BEGIN
		IF @inMessage IS NULL
			SET	@inMessage	= @inEvent_Name;

		EXEC TPW_SERVICE_WF_LOG @inPJob_ID, @tOld_State_ID, @tEvent_ID, @tNew_State_ID, @inMessage;
	END;
