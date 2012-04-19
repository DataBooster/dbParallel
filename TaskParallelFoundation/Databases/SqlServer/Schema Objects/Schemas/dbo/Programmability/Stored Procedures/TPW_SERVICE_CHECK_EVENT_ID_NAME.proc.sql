CREATE PROCEDURE dbo.TPW_SERVICE_CHECK_EVENT_ID_NAME
(
	@outEvent_ID	SMALLINT		OUTPUT,
	@outActivity	NVARCHAR(32)	OUTPUT,
	@outEvent_Name	NVARCHAR(32)	OUTPUT
)
AS
	SET NOCOUNT ON;
	DECLARE	@tEvent_ID		SMALLINT;
	DECLARE	@tActivity		NVARCHAR(32);
	DECLARE	@tEvent_Name	NVARCHAR(32);

	IF @outEvent_Name IS NOT NULL AND @outActivity IS NOT NULL
	BEGIN
		SELECT @tEvent_ID = EVENT_ID FROM TPW_WF_EVENT WHERE EVENT_NAME = @outEvent_Name AND ACTIVITY = @outActivity;
		IF @tEvent_ID IS NULL
		BEGIN
			RAISERROR(N'Invalid @outEvent_Name or @outActivity!', 12, 11);
			RETURN -111;
		END;

		IF @outEvent_ID IS NULL
			SET	@outEvent_ID	= @tEvent_ID;
		ELSE
			IF @outEvent_ID != @tEvent_ID
			BEGIN
				RAISERROR(N'@outEvent_ID mismatches with @outActivity and @outEvent_Name!', 12, 12);
				RETURN -112;
			END;
	END
	ELSE IF @outEvent_ID IS NOT NULL
	BEGIN
		SELECT @tActivity = ACTIVITY, @tEvent_Name = EVENT_NAME FROM TPW_WF_EVENT WHERE EVENT_ID = @outEvent_ID;
		IF @tEvent_Name IS NULL
		BEGIN
			RAISERROR(N'Invalid @outEvent_ID!', 12, 13);
			RETURN -113;
		END;

		IF @outActivity IS NULL
			SET	@outActivity	= @tActivity;
		ELSE
			IF @outActivity != @tActivity
			BEGIN
				RAISERROR(N'@outActivity mismatches with @outEvent_ID!', 12, 14);
				RETURN -114;
			END;

		IF @outEvent_Name IS NULL
			SET	@outEvent_Name	= @tEvent_Name;
		ELSE
			IF @outEvent_Name != @tEvent_Name
			BEGIN
				RAISERROR(N'@outEvent_Name mismatches with @outEvent_ID!', 12, 15);
				RETURN -115;
			END;
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
