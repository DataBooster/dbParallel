CREATE PROCEDURE dbo.TPW_SERVICE_GET_SERVICE_CONFIG
(
	@outPrimary_Interval			TINYINT	OUTPUT,
	@outStandby_Interval			TINYINT	OUTPUT,
	@outDegree_Task_Parallelism		TINYINT	OUTPUT,
	@outMax_Threads_In_Pool			TINYINT	OUTPUT
)
AS
	SET NOCOUNT ON;

	SELECT @outPrimary_Interval			= NUMBER_VALUE FROM dbo.TPW_PUMP_CONFIG WHERE ELEMENT_NAME = N'PRIMARY_INTERVAL';
	SELECT @outStandby_Interval			= NUMBER_VALUE FROM dbo.TPW_PUMP_CONFIG WHERE ELEMENT_NAME = N'STANDBY_INTERVAL';
	SELECT @outDegree_Task_Parallelism	= NUMBER_VALUE FROM dbo.TPW_PUMP_CONFIG WHERE ELEMENT_NAME = N'DEGREE_OF_TASK_PARALLELISM';
	SELECT @outMax_Threads_In_Pool		= NUMBER_VALUE FROM dbo.TPW_PUMP_CONFIG WHERE ELEMENT_NAME = N'MAX_THREADS_IN_POOL';

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
