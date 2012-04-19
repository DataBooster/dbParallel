CREATE VIEW VIEW_TPW_WK_LOG
AS
SELECT
	L.LOG_TIME,
	L.REFER_ID,
	O.STATE_NAME				AS OLD_STATE,
	E.EVENT_NAME				AS EVENT_,
	N.STATE_NAME				AS NEW_STATE,
	L.MESSAGE_
FROM
	(
		SELECT
			LOG_TIME,
			REFER_ID,
			STATE_ID_OLD,
			EVENT_ID,
			STATE_ID_NEW,
			MESSAGE_
		FROM
			TPW_WK_LOG
		UNION ALL
		SELECT
			LOG_TIME,
			REFER_ID,
			STATE_ID_OLD,
			EVENT_ID,
			STATE_ID_NEW,
			MESSAGE_
		FROM
			TPW_WK_LOG_ARCHIVE
	)								L
	INNER JOIN	TPW_WF_STATE		N
	ON	(N.STATE_ID	= L.STATE_ID_NEW)
	LEFT OUTER JOIN	TPW_WF_STATE	O
	ON	(O.STATE_ID	= L.STATE_ID_OLD)
	LEFT OUTER JOIN	TPW_WF_EVENT	E
	ON	(E.EVENT_ID	= L.EVENT_ID);

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
