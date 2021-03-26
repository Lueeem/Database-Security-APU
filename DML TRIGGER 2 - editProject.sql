-- Prepare table to store deleted item from UPDATE / DELETE statements
CREATE TABLE deletedItem (
	historyID uniqueidentifier NOT NULL,
	projectID int NOT NULL,
	projectStatus varchar(255) NOT NULL,
	projectResult varchar(255) NOT NULL,
	projectStart datetime2 NOT NULL,
	projectEnd datetime2
)

-- DML trigger 2: 
-- If Insert, Update, Delete happens to ResearchProject table,
-- gives notification and add record deleted item in deletedItem table.
-- Otherwise,
-- Rollback if backup begins
CREATE TRIGGER trigger_dml_editProject
ON ResearchProject
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	DECLARE @action varchar(10);
	DECLARE @info varchar(1000);
	IF(DATEPART(HOUR,GETDATE()) BETWEEN 2 AND 5)
	BEGIN
		IF EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted)
		BEGIN
			SET @action = 'Update';
			SET @info = 'Update is attempted on ResearchProject table during Full Backup period. This action is rollbacked.';
		END
		ELSE IF EXISTS(SELECT * FROM deleted)
		BEGIN
			SET @action = 'Delete';
			SET @info = 'Delete is attempted on ResearchProject table during Full Backup period. This action is rollbacked.';
		END
		ROLLBACK TRANSACTION;
		INSERT INTO trackDML VALUES (
			NEWID(), @action, SYSTEM_USER, GETDATE(), @info
		)
		PRINT('Action failed, Full Backup is currently running. Please try again after 5:00am.')
	END
	ELSE
	BEGIN
		IF EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted)
		BEGIN
			SET @action = 'Update';
			SET @info = 'Update is attempted on ResearchProject table. deletedItem table is updated with deleted content.';
		END
		ELSE IF EXISTS(SELECT * FROM deleted)
		BEGIN
			SET @action = 'Delete';
			SET @info = 'Delete is attempted on ResearchProject table. deletedItem table is updated with deleted content.';
		END
		-- record deleted item
		INSERT INTO deletedItem (historyID, projectID, projectStatus, projectResult, projectStart, projectEnd)
		SELECT NEWID(), d.projectID, d.projectStatus, d.projectResult, d.projectStart, d.projectEnd 
		FROM deleted d;
		-- record dml track
		INSERT INTO trackDML VALUES (
			NEWID(),
			@action,
			SYSTEM_USER,
			GETDATE(),
			@info
		);
	END
END
