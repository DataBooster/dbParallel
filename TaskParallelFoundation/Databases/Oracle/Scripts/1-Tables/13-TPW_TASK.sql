-- CREATE TABLE
CREATE TABLE XYZ.TPW_TASK
(
	PJOB_ID				NUMBER(10)						NOT NULL,
	TASK_ID				NUMBER(5)						NOT NULL,
	COMMAND_TIMEOUT		NUMBER(3)	DEFAULT 10			NOT NULL,		-- Minutes
	DYNAMIC_SQL_STMT	CLOB							NOT NULL,
	DESCRIPTION_		VARCHAR2(256),
	START_TIME			TIMESTAMP(3),
	END_TIME			TIMESTAMP(3),
	ERROR_MESSAGE		VARCHAR2(256),

	CONSTRAINT PK_TPW_TASK PRIMARY KEY (PJOB_ID, TASK_ID),
	CONSTRAINT FK_TPW_TASK_PJOB_ID FOREIGN KEY (PJOB_ID) REFERENCES XYZ.TPW_PJOB (PJOB_ID) ON DELETE CASCADE
)
STORAGE (INITIAL 64K NEXT 64K);

COMMENT ON COLUMN XYZ.TPW_TASK.TASK_ID IS '0: reserved for Callback after Success; -1: reserved for Callback after Fail;';
COMMENT ON COLUMN XYZ.TPW_TASK.COMMAND_TIMEOUT IS 'Minutes. (Default 10 minutes)';

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
