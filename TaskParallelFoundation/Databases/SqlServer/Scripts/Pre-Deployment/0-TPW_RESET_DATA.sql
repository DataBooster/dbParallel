﻿-- =============================================
-- Script Template
-- =============================================
TRUNCATE TABLE TPW_SYS_ERROR;
TRUNCATE TABLE TPW_PUMP_SERVER;
TRUNCATE TABLE TPW_WK_LOG;
TRUNCATE TABLE TPW_WK_LOG_ARCHIVE;
TRUNCATE TABLE TPW_DBMS_ALERT;
DELETE FROM TPW_PJOB;
DELETE FROM TPW_PJOB_ARCHIVE;

UPDATE	TPW_PUMP_CONFIG
SET		DATE_VALUE	= '2012-01-01'
WHERE	DATE_VALUE	IS NOT NULL;
