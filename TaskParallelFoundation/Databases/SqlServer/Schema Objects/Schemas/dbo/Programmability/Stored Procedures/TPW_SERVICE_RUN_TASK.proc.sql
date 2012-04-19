CREATE PROCEDURE dbo.TPW_SERVICE_RUN_TASK
(
	@inPJob_ID	INT,
	@inTask_ID	SMALLINT
)
AS
	SET NOCOUNT ON;
	DECLARE	@tTableVar	TABLE (DYNAMIC_SQL_STMT	NVARCHAR(MAX));

	UPDATE		TPW_TASK
	SET			START_TIME = GETDATE()
	OUTPUT		DELETED.DYNAMIC_SQL_STMT
	INTO		@tTableVar (DYNAMIC_SQL_STMT)
	WHERE		TASK_ID = @inTask_ID AND PJOB_ID = @inPJob_ID

	IF @@ROWCOUNT > 0
	BEGIN
		DECLARE	@tDynamic_SQL_STMT	NVARCHAR(MAX);

		SELECT	@tDynamic_SQL_STMT = DYNAMIC_SQL_STMT	FROM @tTableVar;

		EXECUTE(@tDynamic_SQL_STMT);

		UPDATE TPW_TASK SET END_TIME = GETDATE() WHERE TASK_ID = @inTask_ID AND PJOB_ID = @inPJob_ID;
	END
	ELSE
		RETURN -120;

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
