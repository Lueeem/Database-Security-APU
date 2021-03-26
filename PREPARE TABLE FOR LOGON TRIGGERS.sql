USE [Umbrella Pharmaceuticals];

CREATE TABLE LogonRecording -- table for recording logon
(
	historyID uniqueidentifier NOT NULL, -- unique id
	loginName varchar(200), -- original_login()
	databaseUser varchar(200), -- user
	sessionID varchar(200), -- @@SPID
	loginDate datetime2 --GETDATE()
);

-- Permission for all user login to write into this table
GRANT INSERT ON [Umbrella Pharmaceuticals].dbo.LogonRecording to Public

