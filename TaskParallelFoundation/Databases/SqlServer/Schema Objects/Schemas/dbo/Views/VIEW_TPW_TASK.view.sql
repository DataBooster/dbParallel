﻿CREATE VIEW VIEW_TPW_TASK
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
