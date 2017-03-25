@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Please globally replace below "XYZ" schema name with your @
@ actual target schema for installation, and make sure that @
@ target schema has following privileges:                   @
@    GRANT CREATE JOB TO XYZ;                               @
@    GRANT SELECT ON USER_SCHEDULER_JOB_RUN_DETAILS TO XYZ; @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


CREATE OR REPLACE PACKAGE XYZ.TPW_SLIM IS


----------------------------------------------------------------------------------------------------
--
--    Copyright 2017 Abel Cheng
--    This source code is subject to terms and conditions of the Apache License, Version 2.0.
--    See http://www.apache.org/licenses/LICENSE-2.0.
--    All other rights reserved.
--    You must not remove this notice, or any other, from this software.
--
--    Source Path:        http://dbparallel.codeplex.com/SourceControl/latest#TaskParallelFoundation/Databases/Oracle/Scripts/3-Packages/TPW_SLIM.pck
--    Created Date:       2017-01-08
--
--    Description:        This is a slim framework of Task Parallel Programming that purely rely on
--                          Oracle built-in DBMS_SCHEDULER package, mainly provides 2 method-calls:
--
--                            tTask_id := XYZ.TPW_SLIM.RUN_ASYNC(sp, arg1, ...);
--
--                            ... ... ... -- do something else
--
--                            XYZ.TPW_SLIM.WAIT_FOR_EXIT(tTask_id);
--
--    Original Author:    Abel Cheng <abelcys@gmail.com>
--    Repository:         http://dbParallel.codeplex.com
--
----------------------------------------------------------------------------------------------------


PROCEDURE SET_ASYNC_TASK_COMMENT
(
	inComments	VARCHAR2
);


FUNCTION RUN_ASYNC
(
	inStored_Procedure	VARCHAR2,
	inArgument1_Value	VARCHAR2
)	RETURN VARCHAR2;

FUNCTION RUN_ASYNC
(
	inStored_Procedure	VARCHAR2,
	inArgument1_Value	VARCHAR2,
	inArgument2_Value	VARCHAR2
)	RETURN VARCHAR2;

FUNCTION RUN_ASYNC
(
	inStored_Procedure	VARCHAR2,
	inArgument1_Value	VARCHAR2,
	inArgument2_Value	VARCHAR2,
	inArgument3_Value	VARCHAR2
)	RETURN VARCHAR2;

FUNCTION RUN_ASYNC
(
	inStored_Procedure	VARCHAR2
)	RETURN VARCHAR2;


PROCEDURE GET_ASYNC_TASK_STATUS
(
	inTask_id			IN	VARCHAR2,		-- The unique name of background task/job
	outStatus			OUT	VARCHAR2,
	outError_number		OUT	PLS_INTEGER,
	outError_message	OUT	VARCHAR2
);


PROCEDURE WAIT_FOR_EXIT
(
	inTask_id			VARCHAR2,			-- The unique name of background task/job
	inTimeout_Seconds	NUMBER		:= 3600	-- Wait the specified number of seconds for the background task/job to exit
);


END TPW_SLIM;
/
CREATE OR REPLACE PACKAGE BODY XYZ.TPW_SLIM IS


tRun_Async_Comments	VARCHAR2(128)	:= 'Asynchronous Execution';


PROCEDURE SET_ASYNC_TASK_COMMENT
(
	inComments	VARCHAR2
)	AS
BEGIN
	tRun_Async_Comments	:= inComments;
END SET_ASYNC_TASK_COMMENT;


FUNCTION GEN_ASYNC_TASK_ID
RETURN VARCHAR2	AS
BEGIN
	RETURN '"A-' || RTRIM(UTL_RAW.CAST_TO_VARCHAR2(UTL_ENCODE.BASE64_ENCODE(SYS_GUID())), '=') || '"';
END GEN_ASYNC_TASK_ID;


FUNCTION RUN_ASYNC
(
	inStored_Procedure	VARCHAR2,
	inArgument1_Value	VARCHAR2
)	RETURN VARCHAR2		AS
tJob_Name	VARCHAR2(32)	:= GEN_ASYNC_TASK_ID;
BEGIN
	DBMS_SCHEDULER.CREATE_JOB(job_name => tJob_Name, job_type => 'STORED_PROCEDURE', job_action => inStored_Procedure, number_of_arguments => 1, comments => tRun_Async_Comments);
	DBMS_SCHEDULER.SET_JOB_ARGUMENT_VALUE(job_name => tJob_Name, argument_position => 1, argument_value => inArgument1_Value);
	DBMS_SCHEDULER.ENABLE(tJob_Name);
	RETURN tJob_Name;
END RUN_ASYNC;


FUNCTION RUN_ASYNC
(
	inStored_Procedure	VARCHAR2,
	inArgument1_Value	VARCHAR2,
	inArgument2_Value	VARCHAR2
)	RETURN VARCHAR2		AS
tJob_Name	VARCHAR2(32)	:= GEN_ASYNC_TASK_ID;
BEGIN
	DBMS_SCHEDULER.CREATE_JOB(job_name => tJob_Name, job_type => 'STORED_PROCEDURE', job_action => inStored_Procedure, number_of_arguments => 2, comments => tRun_Async_Comments);
	DBMS_SCHEDULER.SET_JOB_ARGUMENT_VALUE(job_name => tJob_Name, argument_position => 1, argument_value => inArgument1_Value);
	DBMS_SCHEDULER.SET_JOB_ARGUMENT_VALUE(job_name => tJob_Name, argument_position => 2, argument_value => inArgument2_Value);
	DBMS_SCHEDULER.ENABLE(tJob_Name);
	RETURN tJob_Name;
END RUN_ASYNC;


FUNCTION RUN_ASYNC
(
	inStored_Procedure	VARCHAR2,
	inArgument1_Value	VARCHAR2,
	inArgument2_Value	VARCHAR2,
	inArgument3_Value	VARCHAR2
)	RETURN VARCHAR2		AS
tJob_Name	VARCHAR2(32)	:= GEN_ASYNC_TASK_ID;
BEGIN
	DBMS_SCHEDULER.CREATE_JOB(job_name => tJob_Name, job_type => 'STORED_PROCEDURE', job_action => inStored_Procedure, number_of_arguments => 3, comments => tRun_Async_Comments);
	DBMS_SCHEDULER.SET_JOB_ARGUMENT_VALUE(job_name => tJob_Name, argument_position => 1, argument_value => inArgument1_Value);
	DBMS_SCHEDULER.SET_JOB_ARGUMENT_VALUE(job_name => tJob_Name, argument_position => 2, argument_value => inArgument2_Value);
	DBMS_SCHEDULER.SET_JOB_ARGUMENT_VALUE(job_name => tJob_Name, argument_position => 3, argument_value => inArgument3_Value);
	DBMS_SCHEDULER.ENABLE(tJob_Name);
	RETURN tJob_Name;
END RUN_ASYNC;


FUNCTION RUN_ASYNC
(
	inStored_Procedure	VARCHAR2
)	RETURN VARCHAR2		AS
tJob_Name	VARCHAR2(32)	:= GEN_ASYNC_TASK_ID;
BEGIN
	DBMS_SCHEDULER.CREATE_JOB(job_name => tJob_Name, job_type => 'STORED_PROCEDURE', job_action => inStored_Procedure, number_of_arguments => 0, enabled => TRUE, comments => tRun_Async_Comments);
	RETURN tJob_Name;
END RUN_ASYNC;


PROCEDURE GET_ASYNC_TASK_STATUS
(
	inTask_id			IN	VARCHAR2,		-- The unique name of background task/job
	outStatus			OUT	VARCHAR2,
	outError_number		OUT	PLS_INTEGER,
	outError_message	OUT	VARCHAR2
)	AS
BEGIN
	WITH JLI AS (
		SELECT
			MAX(LOG_ID)	AS LOG_ID
		FROM
			USER_SCHEDULER_JOB_RUN_DETAILS
		WHERE
				STATUS		IS NOT NULL
			AND JOB_NAME	= TRIM('"' FROM inTask_id)
	)
	SELECT
		D.STATUS,
		D.ERROR#,
		D.ADDITIONAL_INFO
	INTO
		outStatus,
		outError_number,
		outError_message
	FROM
		JLI	L JOIN
		USER_SCHEDULER_JOB_RUN_DETAILS	D
		ON (D.LOG_ID = L.LOG_ID);
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		NULL;
END GET_ASYNC_TASK_STATUS;


PROCEDURE WAIT_FOR_EXIT
(
	inTask_id			VARCHAR2,			-- The unique name of background task/job
	inTimeout_Seconds	NUMBER		:= 3600	-- Wait the specified number of seconds for the background task/job to exit
)	AS
tExpire_Time	DATE	:= SYSDATE + (inTimeout_Seconds / 86400.0);
tInterval		NUMBER	:= 0.5;
tStatus			VARCHAR2(32);
tError_Number	PLS_INTEGER;
tError_Message	VARCHAR2(4000);
BEGIN
	LOOP
		GET_ASYNC_TASK_STATUS(inTask_id, tStatus, tError_Number, tError_Message);

		IF tStatus IS NULL THEN
			IF SYSDATE < tExpire_Time THEN
				DBMS_LOCK.SLEEP(tInterval);
				IF tInterval < 1.0 THEN
					tInterval	:= 1.5;
				END IF;
			ELSE
				RAISE_APPLICATION_ERROR(-20445, 'Background job ' || inTask_id || ' time out');
			END IF;
		ELSIF tStatus = 'SUCCEEDED' THEN
			EXIT;
		ELSE
			IF tError_Message IS NULL THEN
				tError_Message	:= 'Background job ' || inTask_id || ' ' || tStatus || ', Error#' || tError_Number;
			END IF;

			IF tError_Number BETWEEN 20000 AND 20999 THEN
				RAISE_APPLICATION_ERROR(-tError_Number, tError_Message);
			ELSE
				RAISE_APPLICATION_ERROR(-20449, tError_Message);
			END IF;
		END IF;
	END LOOP;
END WAIT_FOR_EXIT;


END TPW_SLIM;
/
