CREATE PROCEDURE dbo.TPW_SERVICE_WF_EVENT_HANDLER
(
	@inCurrent_State	SMALLINT,
	@outEvent_ID		SMALLINT	OUTPUT,
	@inEvent_Name		NVARCHAR(32),
	@outNew_State		SMALLINT	OUTPUT,
	@inCheck_State		BIT			= 1	-- TRUE
)
AS
	SET NOCOUNT ON;

	IF @outEvent_ID IS NULL
		SELECT	@outNew_State = STATE_ID_NEW, @outEvent_ID = EVENT_ID
		FROM	TPW_WF_STATE_MACHINE
		WHERE	EVENT_NAME = @inEvent_Name AND STATE_ID_OLD = @inCurrent_State;
	ELSE
		SELECT	@outNew_State = STATE_ID_NEW
		FROM	TPW_WF_STATE_MACHINE
		WHERE	EVENT_ID = @outEvent_ID AND STATE_ID_OLD = @inCurrent_State;

	IF @outNew_State IS NULL
		IF @inCheck_State = 1
		BEGIN
			RAISERROR(N'EVENT can not apply to current STATE!', 13, 31);
			RETURN -131;
		END;
