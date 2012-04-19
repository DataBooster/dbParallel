-- CREATE TABLE
CREATE TABLE XYZ.TPW_WF_STATE
(
	STATE_ID			NUMBER(5)		NOT NULL,
	ACTIVITY			VARCHAR2(32)	NOT NULL,
	STATE_NAME			VARCHAR2(32)	NOT NULL,
	DESCRIPTION_		VARCHAR2(256),
	CONSTRAINT PK_TPW_WF_STATE PRIMARY KEY (STATE_ID),
	CONSTRAINT UK_TPW_WF_STATE UNIQUE (ACTIVITY, STATE_NAME),
	CONSTRAINT FK_TPW_WF_STATE_ACTIVITY FOREIGN KEY (ACTIVITY) REFERENCES XYZ.TPW_WF_ACTIVITY (ACTIVITY)
)
ORGANIZATION INDEX
STORAGE (INITIAL 64K NEXT 64K);

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
