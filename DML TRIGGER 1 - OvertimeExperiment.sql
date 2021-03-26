-- DML trigger 1: 
-- If Insert, Update, Delete happens to Experiment table,
-- gives notification and add record in trackDML table.
-- Otherwise,
-- Rollback if backup begins
 
CREATE TRIGGER trigger_dml_overtimeExperiment
ON Experiment
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
			SET @info = 'Update is attempted on Experiment table during Full Backup period. This action is rollbacked.';
		END
		ELSE IF EXISTS(SELECT * FROM inserted)
		BEGIN
			SET @action = 'Insert';
			SET @info = 'Insert is attempted on Experiment table during Full Backup period. This action is rollbacked.';
		END
		ELSE IF EXISTS(SELECT * FROM deleted)
		BEGIN
			SET @action = 'Delete';
			SET @info = 'Delete is attempted on Experiment table during Full Backup period. This action is rollbacked.';
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
			SET @info = 'Update is attempted on Experiment table.';
		END
		ELSE IF EXISTS(SELECT * FROM inserted)
		BEGIN
			SET @action = 'Insert';
			SET @info = 'Insert is attempted on Experiment table.';
		END
		ELSE IF EXISTS(SELECT * FROM deleted)
		BEGIN
			SET @action = 'Delete';
			SET @info = 'Delete is attempted on Experiment table.';
		END
		INSERT INTO trackDML VALUES (
			NEWID(),
			@action,
			SYSTEM_USER,
			GETDATE(),
			@info
		)
	END
END