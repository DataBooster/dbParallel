CREATE PROCEDURE client.TPW_SCHEDULER_ADD_CALLBACK_FOR_FAIL
(
	@inPJob_ID			INT,
	@inDynamic_SQL_STMT	NVARCHAR(MAX),
	@inCommand_Timeout	TINYINT			= 10,
	@inDescription		NVARCHAR(256)	= N''
)
AS
	SET NOCOUNT ON;
	DECLARE	@tReturn	INT;

	EXEC @tReturn = dbo.TPW_SERVICE_ADD_TASK @inPJob_ID, -1, @inDynamic_SQL_STMT, @inCommand_Timeout, @inDescription;

	RETURN @tReturn;

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
