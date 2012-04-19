CREATE TABLE TPW_PUMP_CONFIG
(
	ELEMENT_NAME		NVARCHAR(32) NOT NULL,
	NUMBER_VALUE		INT,
	DATE_VALUE			DATETIME,
	STRING_VALUE		NVARCHAR(256),
	DESCRIPTION_		NVARCHAR(256),

	CONSTRAINT PK_TPW_PUMP_CONFIG PRIMARY KEY (ELEMENT_NAME),
	CONSTRAINT CK_TPW_PUMP_CONFIG_VALUE CHECK (NUMBER_VALUE IS NOT NULL OR DATE_VALUE IS NOT NULL OR STRING_VALUE IS NOT NULL)
);

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
