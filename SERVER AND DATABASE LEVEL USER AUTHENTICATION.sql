USE [Umbrella Pharmaceuticals];

-- CREATE ROLE - Scientist (Tan Zhe Wen)
CREATE ROLE Scientist;

-- GRANT PRIVILEGE - Scientist (Tan Zhe Wen)
GRANT SELECT, INSERT, UPDATE
ON Experiment TO Scientist;

GRANT SELECT
ON Laboratory TO Scientist;

GRANT SELECT, INSERT, UPDATE
ON ResearchProject TO Scientist;

GRANT SELECT, INSERT, UPDATE
ON TestSubject TO Scientist;

-- CREATE ROLE - Chief Scientist (Tan Zhe Wen)
CREATE ROLE Chief_Scientist;

-- GRANT PRIVILEGE - Chief Scientist (Tan Zhe Wen)
GRANT SELECT
ON Employee TO Chief_Scientist;

GRANT SELECT, INSERT, UPDATE, DELETE
ON Experiment TO Chief_Scientist;

GRANT SELECT
ON Laboratory TO Chief_Scientist;

GRANT SELECT, INSERT, UPDATE, DELETE
ON ResearchProject TO Chief_Scientist;

GRANT SELECT, INSERT, UPDATE, DELETE
ON TestSubject TO Chief_Scientist;

-- CREATE ROLE - Human Resource Manager (How Chun Yu)
CREATE ROLE HumanResource_Manager;

-- GRANT PRIVILEGE - Human Resource Manager (How Chun Yu)
GRANT SELECT, INSERT, UPDATE, DELETE
ON Employee TO HumanResource_Manager;

GRANT SELECT
ON Laboratory TO HumanResource_Manager;

-- CREATE ROLE - Database Admin (How Chun Yu)
CREATE ROLE Database_Admin;

-- GRANT PRIVILEGE - Database Admin (How Chun Yu)
GRANT SELECT, ALTER, UPDATE, INSERT, DELETE 
ON Employee TO Database_Admin WITH GRANT OPTION;
GRANT SELECT, ALTER, UPDATE, INSERT, DELETE 
ON Experiment TO Database_Admin WITH GRANT OPTION;
GRANT SELECT, ALTER, UPDATE, INSERT, DELETE 
ON Laboratory TO Database_Admin WITH GRANT OPTION;
GRANT SELECT, ALTER, UPDATE, INSERT, DELETE 
ON ResearchProject TO Database_Admin WITH GRANT OPTION;
GRANT SELECT, ALTER, UPDATE, INSERT, DELETE 
ON TestSubject TO Database_Admin WITH GRANT OPTION;

-- Stored Procedure (for create login and user)
GO
CREATE PROCEDURE sp_createLoginUser
    @loginName sysname,
    @password varchar(200),
    @username varchar(200),
    @rolename varchar(200),
    @dbname varchar(200)
AS
BEGIN
    DECLARE @createLoginUser nvarchar(max)
    -- dynamic sql to execute the create login and create user
    SET @createLoginUser =	'USE ['  + @dbname + '];' +
							'CREATE LOGIN '+ @loginName +
							' WITH PASSWORD = '''+ @password + ''','+
							'DEFAULT_DATABASE = ['+ @dbname + '],' +
							'CHECK_EXPIRATION = ON,' +
							'CHECK_POLICY = ON;' +
							'CREATE USER ' + @username + ' FOR LOGIN ' + @loginname + ';' + 
							'ALTER ROLE '+ @rolename + ' ADD MEMBER '+ @username + ';'
    EXEC (@createLoginUser) -- Execute prepared scripts
END

--DROP PROCEDURE sp_createLoginUser;

-- User 1, Scientist Role (Tan Zhe Wen)
EXEC sp_createLoginUser @loginname = 'AdamLogin', @password = '123456789@Ab', 
@username = 'Adam', @rolename = 'Scientist', @dbname = 'Umbrella Pharmaceuticals'

-- User 2, Chief Scientist Role (Tan Zhe Wen)
EXEC sp_createLoginUser @loginname = 'BrendanLogin', @password = '123456789@Ab', 
@username = 'Brendan', @rolename = 'Chief_Scientist', @dbname = 'Umbrella Pharmaceuticals'

-- User 1, Human Resource Manager Role (How Chun Yu)
EXEC sp_createLoginUser @loginName = 'CallieLogin', @password = '123456789@Ab', 
@username ='Callie', @rolename = 'HumanResource_Manager', @dbname = 'Umbrella Pharmaceuticals'

-- User 2, Database Admin Role (How Chun Yu) 
EXEC sp_createLoginUser @loginname = 'DevonLogin', @password = '123456789@Ab', 
@username = 'Devon', @rolename = 'Database_Admin', @dbname = 'Umbrella Pharmaceuticals'