CREATE PROCEDURE dbo.TPW_SERVICE_ARCHIVE_PJOB
AS
	SET NOCOUNT ON;
	DECLARE	@tEvent_Name NVARCHAR(32);
	DECLARE	@tNow		DATETIME;
	DECLARE	@tInterval	TINYINT;

	SET	@tEvent_Name	= N'ARCHIVE';
	SET	@tNow			= GETDATE();
	SET	@tInterval		= dbo.TPW_SERVICE_GET_ARCHIVE_INTERVAL();

	UPDATE	dbo.TPW_PUMP_CONFIG
	SET		DATE_VALUE		= @tNow
	WHERE	DATE_VALUE		< DATEADD(minute, -@tInterval, @tNow)
		AND	ELEMENT_NAME	= N'LAST_ARCHIVED';

	IF @@ROWCOUNT > 0
	BEGIN
		DECLARE	@tTableVar	TABLE
		(
			PJOB_ID			INT,
			STATE_ID_OLD	SMALLINT,
			EVENT_ID		SMALLINT,
			STATE_ID_NEW	SMALLINT,
			TASK_COUNT		SMALLINT,
			SCHEDULED_TIME	DATETIME,
			EXPIRY_TIME		DATETIME,
			START_TIME		DATETIME,
			END_TIME		DATETIME,
			USER_APP		NVARCHAR(128),
			USER_NAME		NVARCHAR(64),
			DESCRIPTION_	NVARCHAR(256)
		);

		INSERT INTO @tTableVar
		SELECT
			PJOB_ID,
			STATE_ID	AS STATE_ID_OLD,
			EVENT_ID,
			STATE_ID_NEW,
			TASK_COUNT,
			SCHEDULED_TIME,
			EXPIRY_TIME,
			START_TIME,
			END_TIME,
			USER_APP,
			USER_NAME,
			DESCRIPTION_
		FROM
			dbo.VIEW_TPW_PJOB_STATE_MACHINE
		WHERE
			EVENT_NAME	= @tEvent_Name;

		IF @@ROWCOUNT > 0
		BEGIN
			INSERT INTO dbo.TPW_PJOB_ARCHIVE (PJOB_ID, STATE_ID, TASK_ID_RECORD, SCHEDULED_TIME, EXPIRY_TIME, START_TIME, END_TIME, USER_APP, USER_NAME, DESCRIPTION_)
			SELECT	PJOB_ID, STATE_ID_NEW, TASK_COUNT, SCHEDULED_TIME, EXPIRY_TIME, START_TIME, END_TIME, USER_APP, USER_NAME, DESCRIPTION_
			FROM	@tTableVar;

			INSERT INTO dbo.TPW_WK_LOG (LOG_TIME, REFER_ID, STATE_ID_OLD, EVENT_ID, STATE_ID_NEW, MESSAGE_)
			SELECT	@tNow, PJOB_ID, STATE_ID_OLD, EVENT_ID, STATE_ID_NEW, @tEvent_Name
			FROM	@tTableVar;

			INSERT INTO dbo.TPW_TASK_ARCHIVE (PJOB_ID, TASK_ID, COMMAND_TIMEOUT, DYNAMIC_SQL_STMT, DESCRIPTION_, START_TIME, END_TIME, ERROR_MESSAGE)
			SELECT	T.PJOB_ID, T.TASK_ID, T.COMMAND_TIMEOUT, T.DYNAMIC_SQL_STMT, T.DESCRIPTION_, T.START_TIME, T.END_TIME, T.ERROR_MESSAGE
			FROM	dbo.TPW_TASK		T,
					@tTableVar			J
			WHERE	T.PJOB_ID	= J.PJOB_ID;

			DELETE FROM	dbo.TPW_PJOB
			WHERE	PJOB_ID IN	(SELECT PJOB_ID FROM @tTableVar);
		END;

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
