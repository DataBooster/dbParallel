CREATE PROCEDURE dbo.TPW_SERVICE_LOG_SYS_ERROR
(
	@inReference	NVARCHAR(256),
	@inMessage		NVARCHAR(4000)
)
AS
	SET NOCOUNT ON;

	INSERT INTO TPW_SYS_ERROR (LOG_TIME, REFERENCE_, MESSAGE_)
	VALUES (GETDATE(), @inReference, @inMessage);

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
