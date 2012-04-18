CREATE PROCEDURE client.TPW_SCHEDULER_CREATE_PJOB
(
	@outPJob_ID		INT				OUTPUT,
	@inUser_App		NVARCHAR(128)	= N'',
	@inUser_Name	NVARCHAR(64)	= N'',
	@inDescription	NVARCHAR(256)	= N''
)
AS
	SET NOCOUNT ON;
	DECLARE	@tState_ID	SMALLINT;
	DECLARE	@tMessage	VARCHAR(128);

	SET	@tState_ID	= dbo.TPW_SERVICE_WF_GET_INIT_STATE(N'TPW_PJOB');
	SET	@tMessage	= @inUser_Name + N' Created PJob';

	INSERT INTO TPW_PJOB (STATE_ID, USER_APP, USER_NAME, DESCRIPTION_)
	VALUES (@tState_ID, @inUser_App, @inUser_Name, @inDescription);

	SET	@outPJob_ID = SCOPE_IDENTITY();

	EXEC dbo.TPW_SERVICE_WF_LOG @outPJob_ID, NULL, NULL, @tState_ID, @tMessage;
