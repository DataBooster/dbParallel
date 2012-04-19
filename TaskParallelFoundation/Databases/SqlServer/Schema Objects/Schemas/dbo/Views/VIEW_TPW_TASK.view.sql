CREATE VIEW VIEW_TPW_TASK
AS
SELECT
	PJOB_ID,
	TASK_ID,
	COMMAND_TIMEOUT,
	DYNAMIC_SQL_STMT,
	DESCRIPTION_,
	START_TIME,
	END_TIME,
	ERROR_MESSAGE
FROM
	TPW_TASK

UNION ALL

SELECT
	PJOB_ID,
	TASK_ID,
	COMMAND_TIMEOUT,
	DYNAMIC_SQL_STMT,
	DESCRIPTION_,
	START_TIME,
	END_TIME,
	ERROR_MESSAGE
FROM
	TPW_TASK_ARCHIVE
;

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
