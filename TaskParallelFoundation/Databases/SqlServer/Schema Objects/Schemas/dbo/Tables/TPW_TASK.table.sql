CREATE TABLE TPW_TASK
(
	PJOB_ID				INT							NOT NULL,
	TASK_ID				SMALLINT					NOT NULL,
	COMMAND_TIMEOUT		SMALLINT		DEFAULT 600	NOT NULL,		-- Seconds
	DYNAMIC_SQL_STMT	NVARCHAR(MAX)				NOT NULL,
	DESCRIPTION_		NVARCHAR(256),
	START_TIME			DATETIME,
	END_TIME			DATETIME,
	ERROR_MESSAGE		NVARCHAR(256),

	CONSTRAINT PK_TPW_TASK PRIMARY KEY (PJOB_ID, TASK_ID),
	CONSTRAINT FK_TPW_TASK_PJOB_ID FOREIGN KEY (PJOB_ID) REFERENCES TPW_PJOB (PJOB_ID) ON DELETE CASCADE
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
