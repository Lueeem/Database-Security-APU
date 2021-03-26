--DDL Trigger (Notify and record table creation. Rollback if met with backup time.)
CREATE TRIGGER trigger_tableCreation
ON DATABASE
FOR CREATE_TABLE
AS
BEGIN
	IF(DATEPART(HOUR,GETDATE()) BETWEEN 2 AND 5)
	BEGIN
		ROLLBACK
		INSERT INTO DDLHistory values (
			newID(),
			'CREATE_TABLE',
			SYSTEM_USER,
			GETDATE(),
			'CREATE_TABLE happened on '+GETDATE()
		)
		PRINT 'Action failed. Backup is currently executing. Please try again after 0500.'
	END
	ELSE
	BEGIN
		INSERT INTO DDLHistory values (
			newID(),
			'CREATE_TABLE',
			SYSTEM_USER,
			GETDATE(),
			'Event executed.'
		)
	END
END