CREATE PROCEDURE dbo.TPW_SERVICE_WF_EVENT_HANDLER
(
	@inCurrent_State	SMALLINT,
	@outEvent_ID		SMALLINT	OUTPUT,
	@inEvent_Name		NVARCHAR(32),
	@outNew_State		SMALLINT	OUTPUT,
	@inCheck_State		BIT			= 1	-- TRUE
)
AS
	SET NOCOUNT ON;

	IF @outEvent_ID IS NULL
		SELECT	@outNew_State = STATE_ID_NEW, @outEvent_ID = EVENT_ID
		FROM	TPW_WF_STATE_MACHINE
		WHERE	EVENT_NAME = @inEvent_Name AND STATE_ID_OLD = @inCurrent_State;
	ELSE
		SELECT	@outNew_State = STATE_ID_NEW
		FROM	TPW_WF_STATE_MACHINE
		WHERE	EVENT_ID = @outEvent_ID AND STATE_ID_OLD = @inCurrent_State;

	IF @outNew_State IS NULL
		IF @inCheck_State = 1
		BEGIN
			RAISERROR(N'EVENT can not apply to current STATE!', 13, 31);
			RETURN -131;
		END;

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
