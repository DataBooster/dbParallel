-- CREATE TABLE
CREATE TABLE XYZ.TPW_SYS_ERROR
(
	LOG_TIME			TIMESTAMP(3)	NOT NULL,
	REFERENCE_			VARCHAR2(256),
	MESSAGE_			VARCHAR2(4000)
)
STORAGE (INITIAL 4M NEXT 4M);
