-- CREATE TABLE
CREATE TABLE XYZ.TPW_WF_EVENT
(
	EVENT_ID			NUMBER(5)		NOT NULL,
	ACTIVITY			VARCHAR2(32)	NOT NULL,
	EVENT_NAME			VARCHAR2(32)	NOT NULL,
	DESCRIPTION_		VARCHAR2(256),
	CONSTRAINT PK_TPW_WF_EVENT PRIMARY KEY (EVENT_ID),
	CONSTRAINT UK_TPW_WF_EVENT UNIQUE (ACTIVITY, EVENT_NAME),
	CONSTRAINT FK_TPW_WF_EVENT_ACTIVITY FOREIGN KEY (ACTIVITY) REFERENCES XYZ.TPW_WF_ACTIVITY (ACTIVITY)
)
ORGANIZATION INDEX
STORAGE (INITIAL 32K NEXT 32K BUFFER_POOL KEEP);

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
