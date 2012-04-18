-- CREATE TABLE
CREATE TABLE XYZ.TPW_PUMP_SERVER
(
	SERVER_NAME			VARCHAR2(32) 							NOT NULL,
	SERVICE_BEAT		TIMESTAMP(3)	DEFAULT SYSTIMESTAMP	NOT NULL,
	IS_PRIMARY			CHAR(1)			DEFAULT 'N'				NOT NULL,
--	IP_ADDRESS			VARCHAR2(39),
	SERVICE_ACCOUNT		VARCHAR2(32),
	CONSTRAINT PK_TPW_PUMP_SERVER PRIMARY KEY (SERVER_NAME)
)
ORGANIZATION INDEX
STORAGE (INITIAL 16K NEXT 8K);