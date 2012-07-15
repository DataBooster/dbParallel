CREATE TABLE TPW_DBMS_ALERT
(
	ALERT_NAME			VARCHAR(30)										NOT NULL,
	ALERT_SIGNAL		BIT DEFAULT 0									NOT NULL,
	ALERT_MESSAGE		NVARCHAR(900),
	REFERENCE_COUNT		SMALLINT DEFAULT 0								NOT NULL,
	FIRST_REGISTER		DATETIME DEFAULT GETDATE()						NOT NULL,
	LAST_REGISTER		DATETIME DEFAULT GETDATE()						NOT NULL,
	EXPIRY_TIME			DATETIME DEFAULT DATEADD(hour, 12, GETDATE())	NOT NULL,

	CONSTRAINT PK_TPW_DBMS_ALERT PRIMARY KEY (ALERT_NAME)
);

--	CREATE INDEX IX_TPW_DBMS_ALERT_EXPIRY ON TPW_DBMS_ALERT (EXPIRY_TIME);

----------------------------------------------------------------------------------------------------
--
--	Copyright 2012 Abel Cheng
--	This source code is subject to terms and conditions of the Apache License, Version 2.0.
--	See http://www.apache.org/licenses/LICENSE-2.0.
--	All other rights reserved.
--	You must not remove this notice, or any other, from this software.
--
--	Original Author:	Abel Cheng <abelcys@gmail.com>
--	Created Date:		2012-07-08
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
