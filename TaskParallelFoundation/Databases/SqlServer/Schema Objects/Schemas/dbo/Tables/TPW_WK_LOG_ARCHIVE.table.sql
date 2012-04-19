CREATE TABLE TPW_WK_LOG_ARCHIVE
(
	LOG_TIME			DATETIME	NOT NULL,
	REFER_ID			INT			NOT NULL,

	STATE_ID_OLD		SMALLINT,
	EVENT_ID			SMALLINT,
	STATE_ID_NEW		SMALLINT	NOT NULL,

	MESSAGE_			NVARCHAR(1024)
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
