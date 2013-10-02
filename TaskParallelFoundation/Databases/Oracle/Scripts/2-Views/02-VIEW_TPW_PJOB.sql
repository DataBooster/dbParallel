CREATE OR REPLACE VIEW XYZ.VIEW_TPW_PJOB AS
SELECT
	J.PJOB_ID,
	S.STATE_NAME					AS PJOB_STATE,
	J.TASK_ID_RECORD				AS TASK_COUNT,
	J.SCHEDULED_TIME,
	J.EXPIRY_TIME,
	J.START_TIME,
	J.END_TIME,
	NVL(F.FAILED_COUNT, 0)			AS FAILED_TASKS,
	J.USER_APP,
	J.USER_NAME,
	J.DESCRIPTION_
FROM
	(
		SELECT
			PJOB_ID,
			COUNT(*)			AS FAILED_COUNT
		FROM
			XYZ.VIEW_TPW_TASK
		WHERE
				ERROR_MESSAGE	IS NOT NULL
			AND	TASK_ID			> 0
		GROUP BY
			PJOB_ID
	)	F,
	XYZ.TPW_WF_STATE				S,
	(
		SELECT
			PJOB_ID,
			STATE_ID,
			TASK_ID_RECORD,
			SCHEDULED_TIME,
			EXPIRY_TIME,
			START_TIME,
			END_TIME,
			USER_APP,
			USER_NAME,
			DESCRIPTION_
		FROM
			XYZ.TPW_PJOB

		UNION ALL

		SELECT
			PJOB_ID,
			STATE_ID,
			TASK_ID_RECORD,
			SCHEDULED_TIME,
			EXPIRY_TIME,
			START_TIME,
			END_TIME,
			USER_APP,
			USER_NAME,
			DESCRIPTION_
		FROM
			XYZ.TPW_PJOB_ARCHIVE
	)	J
WHERE
		F.PJOB_ID(+)	= J.PJOB_ID
	AND	S.STATE_ID		= J.STATE_ID

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

WITH READ ONLY;
