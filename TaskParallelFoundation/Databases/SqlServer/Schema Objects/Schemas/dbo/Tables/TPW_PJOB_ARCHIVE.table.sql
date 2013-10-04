CREATE TABLE dbo.TPW_PJOB_ARCHIVE
(
	PJOB_ID				INT				NOT NULL,
	STATE_ID			SMALLINT		NOT NULL,
	TASK_ID_RECORD		SMALLINT		NOT NULL,
	SCHEDULED_TIME		DATETIME		NOT NULL,
	EXPIRY_TIME			DATETIME		NOT NULL,
	START_TIME			DATETIME,
	END_TIME			DATETIME,
	USER_APP			NVARCHAR(128),
	USER_NAME			NVARCHAR(64),
	DESCRIPTION_		NVARCHAR(256),

	CONSTRAINT PK_TPW_PJOB_ARCHIVE PRIMARY KEY (PJOB_ID),
	CONSTRAINT FK_TPW_PJOB_ARCHIVE_STATE_ID FOREIGN KEY (STATE_ID) REFERENCES dbo.TPW_WF_STATE (STATE_ID)
);

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
