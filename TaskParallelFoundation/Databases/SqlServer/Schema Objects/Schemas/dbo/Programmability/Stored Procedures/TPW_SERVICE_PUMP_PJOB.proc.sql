CREATE PROCEDURE dbo.TPW_SERVICE_PUMP_PJOB
(
	@outSwitch_To_Mode	NVARCHAR(8)	OUTPUT
)
AS
	/* SET NOCOUNT ON */
	DECLARE	@tReturn	INT;
	DECLARE	@tNow		DATETIME;
	
	SET	@tNow	= GETDATE();

	UPDATE	dbo.TPW_PUMP_CONFIG
	SET		DATE_VALUE		= @tNow
	WHERE	ELEMENT_NAME	= N'PRIMARY_BEAT';

	EXEC @tReturn = dbo.TPW_SERVICE_ARCHIVE_PJOB;
	IF @tReturn > 0
		EXEC dbo.TPW_SERVICE_EXPIRE_PJOB;

	SELECT
		PJOB_ID
	FROM
		dbo.VIEW_TPW_PJOB_STATE_MACHINE
	WHERE
			SCHEDULED_TIME	<= @tNow
		AND EVENT_NAME		= N'RUN'			-- Can run
	ORDER BY
		PJOB_ID;

	SET	@outSwitch_To_Mode	= N'Primary';

	EXEC dbo.TPW_SERVICE_SERVICE_PING 1;

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
