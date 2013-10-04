CREATE TRIGGER dbo.TRG_TPW_WF_ACTIVITY
ON dbo.TPW_WF_ACTIVITY
AFTER INSERT, UPDATE
AS
	IF EXISTS
	(
		SELECT	I.ACTIVITY
		FROM	INSERTED			I,
				dbo.TPW_WF_STATE	S
		WHERE	S.STATE_ID	= I.BEGIN_STATE_ID
			AND	(S.ACTIVITY <> I.ACTIVITY OR S.STATE_NAME <> I.BEGIN_STATE_NAME)
	)
	BEGIN
		RAISERROR(N'ACTIVITY, BEGIN_STATE_ID and BEGIN_STATE_NAME mismatch!', 11, 2);
		ROLLBACK TRANSACTION;
		RETURN;
	END;

	IF EXISTS
	(
		SELECT	I.ACTIVITY
		FROM	INSERTED			I,
				dbo.TPW_WF_STATE	S
		WHERE	S.STATE_ID	= I.END_STATE_ID
			AND	(S.ACTIVITY <> I.ACTIVITY OR S.STATE_NAME <> I.END_STATE_NAME)
	)
	BEGIN
		RAISERROR(N'ACTIVITY, END_STATE_ID and END_STATE_NAME mismatch!', 11, 2);
		ROLLBACK TRANSACTION;
		RETURN;
	END;

	DECLARE	@tTableVar	TABLE
	(
		ACTIVITY			NVARCHAR(32),
		BEGIN_STATE_ID		SMALLINT,
		BEGIN_STATE_NAME	NVARCHAR(32),
		END_STATE_ID		SMALLINT,
		END_STATE_NAME		NVARCHAR(32)
	);

	INSERT INTO @tTableVar (ACTIVITY, BEGIN_STATE_ID, BEGIN_STATE_NAME, END_STATE_ID, END_STATE_NAME)
	SELECT	ACTIVITY, BEGIN_STATE_ID, BEGIN_STATE_NAME, END_STATE_ID, END_STATE_NAME
	FROM	INSERTED
	WHERE
			(BEGIN_STATE_ID IS NULL AND BEGIN_STATE_NAME IS NOT NULL)
		OR	(BEGIN_STATE_ID IS NOT NULL AND BEGIN_STATE_NAME IS NULL)
		OR	(END_STATE_ID IS NULL AND END_STATE_NAME IS NOT NULL)
		OR	(END_STATE_ID IS NOT NULL AND END_STATE_NAME IS NULL);

	IF @@ROWCOUNT > 0
	BEGIN 
		UPDATE	T
		SET		BEGIN_STATE_ID	= S.STATE_ID
		FROM	@tTableVar			T
		JOIN	dbo.TPW_WF_STATE	S
		ON		(S.ACTIVITY = T.ACTIVITY AND S.STATE_NAME = T.BEGIN_STATE_NAME)
		WHERE	T.BEGIN_STATE_ID	IS NULL;

		UPDATE	T
		SET		BEGIN_STATE_NAME	= S.STATE_NAME
		FROM	@tTableVar			T
		JOIN	dbo.TPW_WF_STATE	S
		ON		(S.STATE_ID = T.BEGIN_STATE_ID AND S.ACTIVITY = T.ACTIVITY)
		WHERE	T.BEGIN_STATE_NAME	IS NULL;

		UPDATE	T
		SET		END_STATE_ID	= S.STATE_ID
		FROM	@tTableVar			T
		JOIN	dbo.TPW_WF_STATE	S
		ON		(S.ACTIVITY = T.ACTIVITY AND S.STATE_NAME = T.END_STATE_NAME)
		WHERE	T.END_STATE_ID		IS NULL;

		UPDATE	T
		SET		END_STATE_NAME	= S.STATE_NAME
		FROM	@tTableVar			T
		JOIN	dbo.TPW_WF_STATE	S
		ON		(S.STATE_ID = T.END_STATE_ID AND S.ACTIVITY = T.ACTIVITY)
		WHERE	T.END_STATE_NAME	IS NULL;

		UPDATE	A
		SET
				BEGIN_STATE_ID		= T.BEGIN_STATE_ID,
				BEGIN_STATE_NAME	= T.BEGIN_STATE_NAME,
				END_STATE_ID		= T.END_STATE_ID,
				END_STATE_NAME		= T.END_STATE_NAME
		FROM	dbo.TPW_WF_ACTIVITY	A
		JOIN	@tTableVar			T
		ON		(A.ACTIVITY = T.ACTIVITY);
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
