CREATE PROCEDURE dbo.TPW_SERVICE_SERVICE_PING
(
	@inIs_Primary	BIT
)
AS
	SET NOCOUNT ON;

	/*	SQL Server 2008
	MERGE INTO dbo.TPW_PUMP_SERVER		P
	USING
	(
		SELECT
			HOST_NAME() 	AS SERVER_NAME,
			GETDATE()		AS SERVICE_BEAT,
			@inIs_Primary	AS IS_PRIMARY,
			SUSER_NAME()	AS SERVICE_ACCOUNT
	)	C
	ON	(P.SERVER_NAME = C.SERVER_NAME)
	WHEN MATCHED THEN
		UPDATE SET
			P.SERVICE_BEAT		= C.SERVICE_BEAT,
			P.IS_PRIMARY		= C.IS_PRIMARY,
			P.SERVICE_ACCOUNT	= C.SERVICE_ACCOUNT
	WHEN NOT MATCHED THEN
		INSERT	(SERVER_NAME, SERVICE_BEAT, IS_PRIMARY, SERVICE_ACCOUNT)
		VALUES	(C.SERVER_NAME, C.SERVICE_BEAT, C.IS_PRIMARY, C.SERVICE_ACCOUNT);
	*/

	--	SQL Server 2005
	UPDATE	dbo.TPW_PUMP_SERVER
	SET
			SERVICE_BEAT	= GETDATE(),
			IS_PRIMARY		= @inIs_Primary,
			SERVICE_ACCOUNT	= SUSER_NAME()
	WHERE	SERVER_NAME		= HOST_NAME();

	IF @@ROWCOUNT = 0
		INSERT INTO dbo.TPW_PUMP_SERVER (SERVER_NAME, SERVICE_BEAT, IS_PRIMARY, SERVICE_ACCOUNT)
		VALUES	(HOST_NAME(), GETDATE(), @inIs_Primary, SUSER_NAME());

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
