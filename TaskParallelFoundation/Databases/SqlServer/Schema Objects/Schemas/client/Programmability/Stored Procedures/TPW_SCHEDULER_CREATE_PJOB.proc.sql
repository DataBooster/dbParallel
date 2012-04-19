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

----------------------------------------------------------------------------------------------------
--
--	Copyright 2012 Abel Cheng
--	This source code is subject to terms and conditions of the Apache License, Version 2.0.
--	See http://www.apache.org/licenses/LICENSE-2.0.
--	All other rights reserved.
--	You must not remove this notice, or any other, from this software.
--
--	Original Author:	Abel Cheng <abelcys@gmail.com>
--	Created Date:		2012-03-23
--	Primary Host:		http://dbParallel.codeplex.com
--	Change Log:
--	Author				Date			Comment
--
--
--
--
--	(Keep clean code rather than complicated code plus long comments.)
--
----------------------------------------------------------------------------------------------------
