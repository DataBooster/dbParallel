CREATE FUNCTION dbo.TPW_SERVICE_GET_EXPIRY_DAY
(
)
RETURNS	TINYINT
AS
BEGIN
	DECLARE	@Expiry_Day		TINYINT;

	SELECT	@Expiry_Day = NUMBER_VALUE
	FROM	TPW_PUMP_CONFIG
	WHERE	ELEMENT_NAME = N'EXPIRY_DAY';

	RETURN	@Expiry_Day;
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
