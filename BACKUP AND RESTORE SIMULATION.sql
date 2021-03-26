USE [master];
--FULL RESTORE
RESTORE DATABASE [Umbrella Pharmaceuticals]
FROM DISK = 'C:\Users\gr4ci\Desktop\DBS_SUBMISSION\BACKUPS\fullBackup.bak'
WITH NORECOVERY, REPLACE;

--DIFFERENTIAL RESTORE
RESTORE DATABASE [Umbrella Pharmaceuticals]
FROM DISK = 'C:\Users\gr4ci\Desktop\DBS_SUBMISSION\BACKUPS\diffBackup.bak'
WITH FILE = 1,
NORECOVERY;

RESTORE DATABASE [Umbrella Pharmaceuticals]
FROM DISK = 'C:\Users\gr4ci\Desktop\DBS_SUBMISSION\BACKUPS\diffBackup.bak'
WITH FILE = 2,
NORECOVERY;

--TRANSACTION LOG RESTORE
RESTORE LOG [Umbrella Pharmaceuticals]
FROM DISK = 'C:\Users\gr4ci\Desktop\DBS_SUBMISSION\BACKUPS\transactionLog.bak'
WITH FILE = 1,
NORECOVERY;

RESTORE LOG [Umbrella Pharmaceuticals]
FROM DISK = 'C:\Users\gr4ci\Desktop\DBS_SUBMISSION\BACKUPS\transactionLog.bak'
WITH FILE = 2,
STOPAT = '2021-3-24 12:00:00',
NORECOVERY;


