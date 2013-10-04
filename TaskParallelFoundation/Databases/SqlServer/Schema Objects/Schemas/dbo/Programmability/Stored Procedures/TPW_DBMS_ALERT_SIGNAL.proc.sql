CREATE PROCEDURE dbo.TPW_DBMS_ALERT_SIGNAL
(
	@inAlert_Name	VARCHAR(30),
	@inMessage		NVARCHAR(900)
)
AS
	SET NOCOUNT ON;

	UPDATE	dbo.TPW_DBMS_ALERT
	SET		ALERT_SIGNAL	= 1,
			ALERT_MESSAGE	= @inMessage
	WHERE	ALERT_NAME		= @inAlert_Name;

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
