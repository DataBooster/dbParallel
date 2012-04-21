CREATE PROCEDURE client.TPW_CALL_START_PJOB
(
	@inPJob_ID			INT,
	@inScheduled_Time	DATETIME	= NULL
)
AS
	SET NOCOUNT ON;

	IF @inScheduled_Time IS NULL
		SET	@inScheduled_Time = GETDATE();

	DECLARE	@tReturn		INT;
	DECLARE	@tExpiry_Time	DATETIME;

	SET	@tExpiry_Time	= DATEADD(day, dbo.TPW_SERVICE_GET_EXPIRY_DAY(), @inScheduled_Time);

	EXEC @tReturn = dbo.TPW_SERVICE_ON_PJOB_EVENT @inPJob_ID, N'START';
	IF @tReturn < 0
		RETURN @tReturn;

	UPDATE	TPW_PJOB
	SET
			SCHEDULED_TIME	= @inScheduled_Time,
			EXPIRY_TIME		= @tExpiry_Time
	WHERE
			PJOB_ID			= @inPJob_ID;

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
