-- CREATE TABLE
CREATE TABLE XYZ.TPW_WK_LOG_ARCHIVE
(
	LOG_TIME			TIMESTAMP(3)	NOT NULL,
	REFER_ID			NUMBER(10)		NOT NULL,

	STATE_ID_OLD		NUMBER(5),
	EVENT_ID			NUMBER(5),
	STATE_ID_NEW		NUMBER(5)		NOT NULL,

	MESSAGE_			VARCHAR2(1024)
)
STORAGE (INITIAL 8M NEXT 8M)
COMPRESS FOR ALL OPERATIONS;

CREATE INDEX XYZ.IX_TPW_WK_LOG_ARCHIVE1 ON XYZ.TPW_WK_LOG_ARCHIVE (LOG_TIME, REFER_ID, STATE_ID_OLD, EVENT_ID, STATE_ID_NEW) COMPRESS;
CREATE INDEX XYZ.IX_TPW_WK_LOG_ARCHIVE2 ON XYZ.TPW_WK_LOG_ARCHIVE (REFER_ID, EVENT_ID, STATE_ID_OLD, STATE_ID_NEW) COMPRESS;

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
