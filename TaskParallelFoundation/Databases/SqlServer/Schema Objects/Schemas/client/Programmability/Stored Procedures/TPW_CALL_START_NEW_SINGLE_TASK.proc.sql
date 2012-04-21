CREATE PROCEDURE client.TPW_CALL_START_NEW_SINGLE_TASK
(
	@inDynamic_SQL		NVARCHAR(MAX),
	@inCommand_Timeout	TINYINT			= 10,
	@inSuccess_Callback	NVARCHAR(MAX)	= NULL,
	@inFail_Callback	NVARCHAR(MAX)	= NULL,
	@inUser_App			NVARCHAR(128)	= N'',
	@inUser_Name		NVARCHAR(64)	= N'',
	@inDescription		NVARCHAR(256)	= N''
)
AS
	SET NOCOUNT ON;
	DECLARE	@tPJob_ID	INT;
	DECLARE	@tReturn	INT;

	EXEC client.TPW_CALL_CREATE_PJOB @tPJob_ID OUTPUT, @inUser_App, @inUser_Name, @inDescription;

	EXEC @tReturn = client.TPW_CALL_ADD_TASK @tPJob_ID, @inDynamic_SQL, @inCommand_Timeout;

	IF @tReturn < 0
		RETURN @tReturn;

	IF @inSuccess_Callback IS NOT NULL
		EXEC client.TPW_CALL_ADD_CALLBACK_FOR_SUCCESS @tPJob_ID, @inSuccess_Callback, @inCommand_Timeout;

	IF @inFail_Callback IS NOT NULL
		EXEC client.TPW_CALL_ADD_CALLBACK_FOR_FAIL @tPJob_ID, @inFail_Callback, 3, @inCommand_Timeout;

	EXEC @tReturn = client.TPW_CALL_START_PJOB @tPJob_ID;

	RETURN @tReturn;

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
