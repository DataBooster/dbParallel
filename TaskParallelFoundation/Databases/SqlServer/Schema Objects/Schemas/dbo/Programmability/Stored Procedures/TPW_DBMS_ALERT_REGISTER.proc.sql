CREATE PROCEDURE dbo.TPW_DBMS_ALERT_REGISTER
(
	@inAlert_Name	VARCHAR(30)
)
AS
	SET NOCOUNT ON;
	DECLARE	@tNow DATETIME, @tExpiry_Time DATETIME;

	SET	@tNow			= GETDATE();
	SET	@tExpiry_Time	= DATEADD(hour, 12, @tNow);

	UPDATE	TPW_DBMS_ALERT
	SET		REFERENCE_COUNT	= REFERENCE_COUNT + 1,
			LAST_REGISTER	= @tNow,
			EXPIRY_TIME		= CASE WHEN @tExpiry_Time < EXPIRY_TIME THEN EXPIRY_TIME ELSE @tExpiry_Time END
	WHERE	ALERT_NAME		= @inAlert_Name;

	IF @@ROWCOUNT = 0
		INSERT INTO	TPW_DBMS_ALERT (ALERT_NAME, ALERT_SIGNAL, REFERENCE_COUNT, FIRST_REGISTER, LAST_REGISTER, EXPIRY_TIME)
		VALUES (@inAlert_Name, 0, 0, @tNow, @tNow, @tExpiry_Time);

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
