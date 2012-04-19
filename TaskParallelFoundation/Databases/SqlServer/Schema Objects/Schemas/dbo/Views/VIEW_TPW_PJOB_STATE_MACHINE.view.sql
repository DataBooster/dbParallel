CREATE VIEW VIEW_TPW_PJOB_STATE_MACHINE
AS
SELECT
	J.PJOB_ID,
	J.STATE_ID,
	J.TASK_ID_RECORD		AS TASK_COUNT,
	J.SCHEDULED_TIME,
	J.EXPIRY_TIME,
	J.START_TIME,
	J.END_TIME,
	J.USER_APP,
	J.USER_NAME,
	J.DESCRIPTION_,

	M.EVENT_ID,
	M.STATE_ID_NEW,
	M.ACTIVITY,
	M.STATE_NAME_OLD		AS STATE_NAME,
	M.EVENT_NAME,
	M.STATE_NAME_NEW
FROM
	TPW_PJOB				J,
	TPW_WF_STATE_MACHINE	M
WHERE
	J.STATE_ID	= M.STATE_ID_OLD;


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
