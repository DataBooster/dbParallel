﻿ALTER TABLE TPW_WF_ACTIVITY ADD CONSTRAINT FK_TPW_WF_ACTIVITY_SN0 FOREIGN KEY (ACTIVITY, BEGIN_STATE_NAME) REFERENCES TPW_WF_STATE (ACTIVITY, STATE_NAME);