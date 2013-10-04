CREATE PROCEDURE dbo.TPW_DBMS_ALERT_REMOVE
(
	@inAlert_Name	VARCHAR(30)
)
AS
	SET NOCOUNT ON;

	DELETE	FROM	dbo.TPW_DBMS_ALERT
	WHERE	ALERT_NAME	= @inAlert_Name
		AND	REFERENCE_COUNT	<= 1;

	IF @@ROWCOUNT = 0
		UPDATE	dbo.TPW_DBMS_ALERT
		SET		REFERENCE_COUNT	= REFERENCE_COUNT - 1
		WHERE	ALERT_NAME		= @inAlert_Name;

----------------------------------------------------------------------------------------------------
--
--	Copyright 2012 Abel Cheng
--	This source code is subject to terms and conditions of the Apache License, Version 2.0.
--	See http://www.apache.org/licenses/LICENSE-2.0.
--	All other rights reserved.
--	You must not remove this notice, or any other, from this software.
--
--	Original Author:	Abel Cheng <abelcys@gmail.com>
--	Created Date:		2012-07-12
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
