CREATE PROCEDURE dbo.TPW_SERVICE_EXPIRE_PJOB
AS
	SET NOCOUNT ON
	DECLARE	@tEvent_Name	NVARCHAR(32);
	DECLARE	@tNow			DATETIME;
	DECLARE	@tInterval		TINYINT;

	SET	@tEvent_Name	= N'EXPIRE';
	SET	@tNow			= GETDATE();
	SET	@tInterval		= dbo.TPW_SERVICE_GET_EXPIRE_INTERVAL();

	UPDATE	TPW_PUMP_CONFIG
	SET		DATE_VALUE		= @tNow
	WHERE	DATE_VALUE		< DATEADD(hour, -@tInterval, @tNow)
		AND	ELEMENT_NAME	= N'LAST_EXPIRED';

	IF @@ROWCOUNT > 0
	BEGIN
		DECLARE	@tTableVar	TABLE
		(
			PJOB_ID			INT,
			STATE_ID_NEW	SMALLINT
		);

		INSERT INTO TPW_WK_LOG (LOG_TIME, REFER_ID, STATE_ID_OLD, EVENT_ID, STATE_ID_NEW, MESSAGE_)
		OUTPUT	INSERTED.REFER_ID, INSERTED.STATE_ID_NEW
		INTO	@tTableVar (PJOB_ID, STATE_ID_NEW)
		SELECT
			@tNow				AS LOG_TIME,
			PJOB_ID				AS REFER_ID,
			STATE_ID,
			EVENT_ID,
			STATE_ID_NEW,
			@tEvent_Name		AS MESSAGE_
		FROM
			VIEW_TPW_PJOB_STATE_MACHINE
		WHERE
				EXPIRY_TIME	< @tNow
			AND EVENT_NAME	= @tEvent_Name;

		IF @@ROWCOUNT > 0
			UPDATE	S
			SET		S.STATE_ID	= T.STATE_ID_NEW
			FROM	TPW_PJOB	S
			JOIN	@tTableVar	T
			ON		(S.PJOB_ID	= T.PJOB_ID);

		RETURN 1;
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
