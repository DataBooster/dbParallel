CREATE PROCEDURE dbo.TPW_SERVICE_SET_SIGNAL
(
	@inPJob_ID			INT,
	@inOld_State_ID		SMALLINT,
	@inEvent_Name		NVARCHAR(32),
	@inNew_State_ID		SMALLINT
)
AS
	DECLARE	@tAlert_Name	VARCHAR(30);

	IF @inNew_State_ID <> @inOld_State_ID
		IF EXISTS
		(
			SELECT 1
			FROM
				TPW_WF_STATE	O,
				TPW_WF_STATE	N
			WHERE
					O.STATE_ID	= @inOld_State_ID
				AND	N.STATE_ID	= @inNew_State_ID
				AND	O.IS_DONE	= 0
				AND	N.IS_DONE	= 1
		)
		BEGIN
			SET	@tAlert_Name	= dbo.TPW_SERVICE_GET_ALERT_NAME(@inPJob_ID);
			EXEC TPW_DBMS_ALERT_SIGNAL @tAlert_Name, @inEvent_Name
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
--	Created Date:		2012-07-13
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
