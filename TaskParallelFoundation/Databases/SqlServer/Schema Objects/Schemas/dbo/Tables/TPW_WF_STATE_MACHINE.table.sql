CREATE TABLE dbo.TPW_WF_STATE_MACHINE
(
	STATE_ID_OLD		SMALLINT		NOT NULL,
	EVENT_ID			SMALLINT		NOT NULL,
	STATE_ID_NEW		SMALLINT		NOT NULL,

	ACTIVITY			NVARCHAR(32)	NOT NULL,
	STATE_NAME_OLD		NVARCHAR(32)	NOT NULL,
	EVENT_NAME			NVARCHAR(32)	NOT NULL,
	STATE_NAME_NEW		NVARCHAR(32)	NOT NULL,

	DESCRIPTION_		NVARCHAR(256),

	CONSTRAINT PK_TPW_WF_STATE_MACHINE PRIMARY KEY (STATE_ID_OLD, EVENT_ID),
	CONSTRAINT UK_TPW_WF_STATE_MACHINE UNIQUE (ACTIVITY, STATE_NAME_OLD, EVENT_NAME),
	CONSTRAINT FK_TPW_WF_STATE_MACHINE_SID0 FOREIGN KEY (STATE_ID_OLD) REFERENCES dbo.TPW_WF_STATE (STATE_ID),
	CONSTRAINT FK_TPW_WF_STATE_MACHINE_EID FOREIGN KEY (EVENT_ID) REFERENCES dbo.TPW_WF_EVENT (EVENT_ID),
	CONSTRAINT FK_TPW_WF_STATE_MACHINE_SID1 FOREIGN KEY (STATE_ID_NEW) REFERENCES dbo.TPW_WF_STATE (STATE_ID),
	CONSTRAINT FK_TPW_WF_STATE_MACHINE_SN0 FOREIGN KEY (ACTIVITY, STATE_NAME_OLD) REFERENCES dbo.TPW_WF_STATE (ACTIVITY, STATE_NAME),
	CONSTRAINT FK_TPW_WF_STATE_MACHINE_EN FOREIGN KEY (ACTIVITY, EVENT_NAME) REFERENCES dbo.TPW_WF_EVENT (ACTIVITY, EVENT_NAME),
	CONSTRAINT FK_TPW_WF_STATE_MACHINE_SN1 FOREIGN KEY (ACTIVITY, STATE_NAME_NEW) REFERENCES dbo.TPW_WF_STATE (ACTIVITY, STATE_NAME),

	CONSTRAINT UK_TPW_WF_STATE_MACHINE_EV UNIQUE (EVENT_ID, STATE_ID_OLD)
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
