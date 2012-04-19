CREATE PROCEDURE dbo.TPW_SERVICE_COMPLETE_PJOB
(
	@inPJob_ID	INT
)
AS
	SET NOCOUNT ON;
	DECLARE	@tReturn	INT;

	EXEC @tReturn = TPW_SERVICE_ON_PJOB_EVENT @inPJob_ID, N'COMPLETE';
	IF @tReturn < 0
		RETURN @tReturn;

	UPDATE	TPW_PJOB
	SET		END_TIME	= GETDATE()
	WHERE	END_TIME	IS NULL
		AND	PJOB_ID		= @inPJob_ID;

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
