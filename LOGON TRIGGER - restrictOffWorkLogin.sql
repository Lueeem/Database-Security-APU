-- Goal: Disallow people to log into database during full backup from 2am to 5am daily
CREATE TRIGGER trigger_logon_restrictOffWorkLogin
ON ALL SERVER
FOR LOGON
AS
BEGIN
	IF(DATEPART(HOUR,GETDATE()) BETWEEN 2 AND 5)
	BEGIN
		ROLLBACK
		PRINT 'Full Backup is currently running. Please try again after 5:00AM.'
	END
END

