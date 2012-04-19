CREATE PROCEDURE dbo.TPW_SERVICE_FAULT_TASK
(
	@inPJob_ID			INT,
	@inTask_ID			SMALLINT,
	@inError_Message	NVARCHAR(1024)
)
AS
	SET NOCOUNT ON;
	DECLARE	@tReturn	INT;

	IF @inError_Message IS NULL
		SET	@inError_Message = N'';

	UPDATE	TPW_TASK
	SET
		END_TIME		= GETDATE(),
		ERROR_MESSAGE	= @inError_Message
	WHERE
			END_TIME	IS NULL
		AND TASK_ID		= @inTask_ID
		AND PJOB_ID		= @inPJob_ID;

	SET	@inError_Message = LEFT(N'[Task_ID=' + CAST(@inTask_ID AS NVARCHAR(10)) + N']' + @inError_Message, 1024);

	EXEC @tReturn = TPW_SERVICE_ON_PJOB_EVENT @inPJob_ID, N'FAULT', 0, 1, @inError_Message;

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
