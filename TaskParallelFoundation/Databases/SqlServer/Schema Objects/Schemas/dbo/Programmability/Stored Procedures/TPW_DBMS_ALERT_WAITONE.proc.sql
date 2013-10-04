CREATE PROCEDURE dbo.TPW_DBMS_ALERT_WAITONE
(
	@inAlert_Name	VARCHAR(30),
	@outMessage		VARCHAR(900)	OUTPUT,
	@outStatus		BIT				OUTPUT,	--	0 - alert occurred; 1 - timeout occurred;
	@inTimeout		INT	= 43200				--	The maximum time to wait for this alert.  If no alert occurs before timeout seconds, then this call will return with status of 1. If the named alert has not been registered then the this call will return after the timeout period expires.
)
AS
	DECLARE @tStatus_Polling_Interval	VARCHAR(11);
	DECLARE	@tTimeout		DATETIME;
	DECLARE	@tAlert_Signal	BIT;

	SELECT	@tStatus_Polling_Interval = STRING_VALUE
	FROM	dbo.TPW_PUMP_CONFIG
	WHERE	ELEMENT_NAME = N'STATUS_POLLING_INTERVAL';

	SET		@tTimeout	= DATEADD(second, @inTimeout, GETDATE());
	SET		@outStatus	= 1;

	WHILE (GETDATE() <= @tTimeout)
	BEGIN
		SELECT	@tAlert_Signal	= ALERT_SIGNAL,
				@outMessage		= ALERT_MESSAGE
		FROM	dbo.TPW_DBMS_ALERT
		WHERE	ALERT_NAME	= @inAlert_Name;

		IF @tAlert_Signal = 0
			WAITFOR DELAY @tStatus_Polling_Interval;
		ELSE
		BEGIN
			SET	@outStatus	= 0;
			BREAK;
		END;
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
