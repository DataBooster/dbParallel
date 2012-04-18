CREATE PROCEDURE dbo.TPW_SERVICE_WF_LOG
(
	@inRefer_ID			INT,
	@inState_ID_Old		SMALLINT,
	@inEvent_ID			SMALLINT,
	@inState_ID_New		SMALLINT,
	@inMessage			NVARCHAR(1024)
)
AS
	SET NOCOUNT ON;

	INSERT INTO TPW_WK_LOG (LOG_TIME, REFER_ID, STATE_ID_OLD, EVENT_ID, STATE_ID_NEW, MESSAGE_)
	VALUES (GETDATE(), @inRefer_ID, @inState_ID_Old, @inEvent_ID, @inState_ID_New, @inMessage);
