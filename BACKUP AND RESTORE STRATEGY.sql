--SET RECOVERY MODEL AS FULL
USE [master];  
ALTER DATABASE [Umbrella Pharmaceuticals] SET RECOVERY FULL;  

USE [Umbrella Pharmaceuticals];
--FULL BACKUP
BACKUP DATABASE [Umbrella Pharmaceuticals]
TO DISK = 'C:\Users\gr4ci\Desktop\DBS_SUBMISSION\BACKUPS\fullBackup.bak';

--DIFFERENTIAL BACKUP
BACKUP DATABASE [Umbrella Pharmaceuticals]
TO DISK = 'C:\Users\gr4ci\Desktop\DBS_SUBMISSION\BACKUPS\diffBackup.bak'
WITH DIFFERENTIAL;

--TRANSACTION LOG BACKUP
BACKUP LOG [Umbrella Pharmaceuticals]
TO DISK = 'C:\Users\gr4ci\Desktop\DBS_SUBMISSION\BACKUPS\transactionLog.bak';

