CREATE PROCEDURE dbo.TPW_SERVICE_RUN_PJOB
(
	@inPJob_ID	INT
)
AS
	/* SET NOCOUNT ON */
	DECLARE	@tReturn	INT;

	EXEC @tReturn = dbo.TPW_SERVICE_ON_PJOB_EVENT @inPJob_ID, N'RUN';
	IF @tReturn < 0
		RETURN @tReturn;

	UPDATE	dbo.TPW_PJOB
	SET		START_TIME	= GETDATE()
	WHERE	PJOB_ID		= @inPJob_ID;

	SELECT
		PJOB_ID,
		TASK_ID,
		COMMAND_TIMEOUT
	FROM
		dbo.TPW_TASK
	WHERE
		PJOB_ID	= @inPJob_ID;

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
