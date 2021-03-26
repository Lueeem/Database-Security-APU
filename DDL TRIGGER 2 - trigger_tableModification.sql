--DDL Trigger 2 (Notify and rollbacktable alteration and deletion)
CREATE TRIGGER trigger_tableModification
ON DATABASE
FOR DROP_TABLE, ALTER_TABLE
AS
BEGIN
	DECLARE @type varchar(1000) = EVENTDATA().value(
		'(/EVENT_INSTANCE/EventType)[1]',
		'varchar(1000)'
	)
	ROLLBACK
	INSERT INTO DDLHistory VALUES (
		newID(),
		@type,
		SYSTEM_USER,
		GETDATE(),
		'Attempt to modify table without permission'
	)
	PRINT 'Table alteration permission from Database Admin is required. Please consult with Database Admin.'
END