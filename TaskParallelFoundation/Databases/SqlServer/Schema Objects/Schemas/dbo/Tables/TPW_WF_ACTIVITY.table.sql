﻿CREATE TABLE TPW_WF_ACTIVITY
(
	ACTIVITY			NVARCHAR(32)	NOT NULL,
	DESCRIPTION_		NVARCHAR(256),
	BEGIN_STATE_ID		SMALLINT,
	BEGIN_STATE_NAME	NVARCHAR(32),
	END_STATE_ID		SMALLINT,
	END_STATE_NAME		NVARCHAR(32),
	CONSTRAINT PK_TPW_WF_ACTIVITY PRIMARY KEY (ACTIVITY)
);
