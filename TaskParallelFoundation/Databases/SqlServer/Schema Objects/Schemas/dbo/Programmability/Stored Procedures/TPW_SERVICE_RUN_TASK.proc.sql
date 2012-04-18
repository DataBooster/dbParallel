﻿CREATE PROCEDURE dbo.TPW_SERVICE_RUN_TASK
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