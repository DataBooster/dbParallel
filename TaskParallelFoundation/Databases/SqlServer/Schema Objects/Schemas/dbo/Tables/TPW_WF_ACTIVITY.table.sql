CREATE TABLE dbo.TPW_WF_ACTIVITY
(
	ACTIVITY			NVARCHAR(32)	NOT NULL,
	DESCRIPTION_		NVARCHAR(256),
	BEGIN_STATE_ID		SMALLINT,
	BEGIN_STATE_NAME	NVARCHAR(32),
	END_STATE_ID		SMALLINT,
	END_STATE_NAME		NVARCHAR(32),
	CONSTRAINT PK_TPW_WF_ACTIVITY PRIMARY KEY (ACTIVITY)
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
