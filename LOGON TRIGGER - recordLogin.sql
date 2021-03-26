CREATE TRIGGER trigger_logon_recordLogin
ON ALL SERVER
FOR LOGON
AS
BEGIN
	INSERT INTO [Umbrella Pharmaceuticals].dbo.LogonRecording 
	VALUES (
		NEWID(),
		ORIGINAL_LOGIN(),
		USER, 
		@@SPID,
		GETDATE()
	)
	PRINT 'New Login recorded.'
END

