CREATE FUNCTION dbo.TPW_SERVICE_WF_GET_INIT_STATE
(
	@inActivity		NVARCHAR(32)
)
RETURNS	SMALLINT
AS
BEGIN
	DECLARE	@tBegin_State_ID	SMALLINT;

	SELECT @tBegin_State_ID = BEGIN_STATE_ID FROM TPW_WF_ACTIVITY WHERE ACTIVITY = @inActivity;

	RETURN @tBegin_State_ID;
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
