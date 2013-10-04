CREATE PROCEDURE dbo.TPW_SERVICE_WAIT_PJOB
(
	@inPJob_ID	INT
)
AS
	SET NOCOUNT ON;
	DECLARE	@tIs_Done		BIT;
	DECLARE	@tAlert_Name	VARCHAR(30);	--	:= GET_ALERT_NAME(inPJob_ID);
	DECLARE	@tMessage		NVARCHAR(32);
	DECLARE	@tStatus		BIT;

	SET	@tAlert_Name = dbo.TPW_SERVICE_GET_ALERT_NAME(@inPJob_ID);
	EXEC dbo.TPW_DBMS_ALERT_REGISTER @tAlert_Name;

	SELECT	@tIs_Done = S.IS_DONE
	FROM
			dbo.TPW_WF_STATE	S,
			dbo.TPW_PJOB		J
	WHERE
			S.STATE_ID	= J.STATE_ID
		AND	J.PJOB_ID	= @inPJob_ID;

	IF @tIs_Done = 0
		EXEC dbo.TPW_DBMS_ALERT_WAITONE @tAlert_Name, @tMessage OUTPUT, @tStatus OUTPUT;

	EXEC dbo.TPW_DBMS_ALERT_REMOVE @tAlert_Name;

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
