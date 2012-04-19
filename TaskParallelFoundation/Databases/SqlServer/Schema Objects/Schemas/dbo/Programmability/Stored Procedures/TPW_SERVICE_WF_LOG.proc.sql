CREATE PROCEDURE dbo.TPW_SERVICE_WF_LOG
(
	@inRefer_ID			INT,
	@inState_ID_Old		SMALLINT,
	@inEvent_ID			SMALLINT,
	@inState_ID_New		SMALLINT,
	@inMessage			NVARCHAR(1024)
)
AS
	SET NOCOUNT ON;

	INSERT INTO TPW_WK_LOG (LOG_TIME, REFER_ID, STATE_ID_OLD, EVENT_ID, STATE_ID_NEW, MESSAGE_)
	VALUES (GETDATE(), @inRefer_ID, @inState_ID_Old, @inEvent_ID, @inState_ID_New, @inMessage);

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
