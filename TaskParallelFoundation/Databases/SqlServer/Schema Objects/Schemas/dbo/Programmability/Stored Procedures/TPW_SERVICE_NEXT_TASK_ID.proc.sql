CREATE PROCEDURE dbo.TPW_SERVICE_NEXT_TASK_ID
(
	@inPJob_ID	INT,
	@outTask_ID	SMALLINT	OUTPUT
)
AS
	SET NOCOUNT ON;
	DECLARE	@tTableVar	TABLE (TASK_ID	SMALLINT);

	UPDATE	TPW_PJOB
	SET		TASK_ID_RECORD	= TASK_ID_RECORD + 1
	OUTPUT	INSERTED.TASK_ID_RECORD
	INTO	@tTableVar (TASK_ID)
	WHERE	PJOB_ID	= @inPJob_ID;

	SELECT	@outTask_ID = TASK_ID	FROM @tTableVar;

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
