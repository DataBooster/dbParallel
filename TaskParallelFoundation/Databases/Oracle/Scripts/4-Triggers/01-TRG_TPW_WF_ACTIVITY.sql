CREATE OR REPLACE TRIGGER XYZ.TRG_TPW_WF_ACTIVITY
BEFORE INSERT OR UPDATE ON XYZ.TPW_WF_ACTIVITY
FOR EACH ROW
BEGIN
	XYZ.TPW_SERVICE.CHECK_STATE_ID_NAME(:new.BEGIN_STATE_ID, :new.ACTIVITY, :new.BEGIN_STATE_NAME);
	XYZ.TPW_SERVICE.CHECK_STATE_ID_NAME(:new.END_STATE_ID, :new.ACTIVITY, :new.END_STATE_NAME);
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
