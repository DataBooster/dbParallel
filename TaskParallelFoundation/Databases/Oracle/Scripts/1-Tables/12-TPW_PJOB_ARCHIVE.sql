-- CREATE TABLE
CREATE TABLE XYZ.TPW_PJOB_ARCHIVE
(
	PJOB_ID				NUMBER(10)		NOT NULL,
	STATE_ID			NUMBER(5)		NOT NULL,
	TASK_ID_RECORD		NUMBER(5)		NOT NULL,
	SCHEDULED_TIME		DATE			NOT NULL,
	EXPIRY_TIME			DATE			NOT NULL,
	START_TIME			TIMESTAMP(3),
	END_TIME			TIMESTAMP(3),
	USER_APP			VARCHAR2(128),
	USER_NAME			VARCHAR2(64),
	DESCRIPTION_		VARCHAR2(256),

	CONSTRAINT PK_TPW_PJOB_ARCHIVE PRIMARY KEY (PJOB_ID),
	CONSTRAINT FK_TPW_PJOB_ARCHIVE_STATE_ID FOREIGN KEY (STATE_ID) REFERENCES XYZ.TPW_WF_STATE (STATE_ID)
)
STORAGE (INITIAL 4M NEXT 4M)
COMPRESS FOR ALL OPERATIONS;

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
