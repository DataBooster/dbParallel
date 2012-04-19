-- Create/Recreate primary, unique and foreign key constraints
ALTER TABLE XYZ.TPW_WF_ACTIVITY ADD CONSTRAINT FK_TPW_WF_ACTIVITY_SID0 FOREIGN KEY (BEGIN_STATE_ID) REFERENCES XYZ.TPW_WF_STATE (STATE_ID);
ALTER TABLE XYZ.TPW_WF_ACTIVITY ADD CONSTRAINT FK_TPW_WF_ACTIVITY_SID1 FOREIGN KEY (END_STATE_ID) REFERENCES XYZ.TPW_WF_STATE (STATE_ID);
ALTER TABLE XYZ.TPW_WF_ACTIVITY ADD CONSTRAINT FK_TPW_WF_ACTIVITY_SN0 FOREIGN KEY (ACTIVITY, BEGIN_STATE_NAME) REFERENCES XYZ.TPW_WF_STATE (ACTIVITY, STATE_NAME);
ALTER TABLE XYZ.TPW_WF_ACTIVITY ADD CONSTRAINT FK_TPW_WF_ACTIVITY_SN1 FOREIGN KEY (ACTIVITY, END_STATE_NAME) REFERENCES XYZ.TPW_WF_STATE (ACTIVITY, STATE_NAME);

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
