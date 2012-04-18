CREATE PROCEDURE dbo.TPW_SERVICE_CHECK_STATE_ID_NAME
(
	@outState_ID	SMALLINT		OUTPUT,
	@outActivity	NVARCHAR(32)	OUTPUT,
	@outState_Name	NVARCHAR(32)	OUTPUT
)
AS
	SET NOCOUNT ON;
	DECLARE	@tState_ID		SMALLINT;
	DECLARE	@tActivity		NVARCHAR(32);
	DECLARE	@tState_Name	NVARCHAR(32);

	IF @outState_Name IS NOT NULL AND @outActivity IS NOT NULL
	BEGIN
		SELECT @tState_ID = STATE_ID FROM TPW_WF_STATE WHERE STATE_NAME = @outState_Name AND ACTIVITY = @outActivity;
		IF @tState_ID IS NULL
		BEGIN
			RAISERROR(N'Invalid @outState_Name or @outActivity!', 11, 1);
			RETURN -101;
		END;

		IF @outState_ID IS NULL
			SET	@outState_ID	= @tState_ID;
		ELSE
			IF @outState_ID != @tState_ID
			BEGIN
				RAISERROR(N'@outState_ID mismatches with @outActivity and @outState_Name!', 11, 2);
				RETURN -102;
			END;
	END
	ELSE IF @outState_ID IS NOT NULL
	BEGIN
		SELECT @tActivity = ACTIVITY, @tState_Name = STATE_NAME FROM TPW_WF_STATE WHERE STATE_ID = @outState_ID;
		IF @tState_Name IS NULL
		BEGIN
			RAISERROR(N'Invalid @outState_ID!', 11, 3);
			RETURN -103;
		END;

		IF @outActivity IS NULL
			SET	@outActivity	= @tActivity;
		ELSE
			IF @outActivity != @tActivity
			BEGIN
				RAISERROR(N'@outActivity mismatches with @outState_ID!', 11, 4);
				RETURN -104;
			END;

		IF @outState_Name IS NOT NULL
			SET	@outState_Name	= @tState_Name;
		ELSE
			IF @outState_Name != @tState_Name
			BEGIN
				RAISERROR(N'@outState_Name mismatches with @outState_ID!', 11, 5);
				RETURN -105;
			END;
	END;
