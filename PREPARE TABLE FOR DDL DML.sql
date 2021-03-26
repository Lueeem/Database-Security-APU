USE [Umbrella Pharmaceuticals];

-- table for tracking DDL trigger
CREATE TABLE DDLHistory
(
	historyID uniqueidentifier NOT NULL,
	eventType varchar(1000),
	attemptUser varchar(100),
	attemptTime datetime2,
	attemptInfo varchar(1000)
)

-- table for tracking DML trigger
CREATE TABLE trackDML
(
	historyID uniqueidentifier NOT NULL,
	actionType varchar(1000),
	attemptUser varchar(100),
	attemptTime datetime2,
	attemptInfo varchar(1000)
)

