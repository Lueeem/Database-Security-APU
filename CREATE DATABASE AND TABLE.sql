CREATE DATABASE [Umbrella Pharmaceuticals];

USE [Umbrella Pharmaceuticals];

CREATE TABLE ResearchProject (
	projectID int NOT NULL,
	projectStatus varchar(255) NOT NULL,
	projectResult varchar(255) NOT NULL,
	projectStart datetime2,
	projectEnd datetime2,
	PRIMARY KEY(projectID)
);

CREATE TABLE Experiment (
	experimentID int NOT NULL,
	experimentType varchar(255) NOT NULL,
	experimentStart datetime2,
	experimentEnd datetime2,
	experimentResult varchar(255) NOT NULL,
	experimentStatus varchar(255) NOT NULL,
	PRIMARY KEY(experimentID)
);

CREATE TABLE Laboratory (
	labID int NOT NULL,
	labName varchar(255) NOT NULL,
	labObjective varchar(255) NOT NULL,
	PRIMARY KEY(labID)
);

CREATE TABLE Employee (
	employeeID int NOT NULL,
	employeeName varchar(255) NOT NULL,
	employeeExpertise varchar(255) NOT NULL,
	employeePhoneNumber varchar(255) NOT NULL,
	employeePosition varchar(255) NOT NULL,
	employeeEmail varchar(255) NOT NULL,
	labID int NOT NULL,
	projectID int NOT NULL,
	experimentID int NOT NULL,
	PRIMARY KEY(employeeID),
	FOREIGN KEY(labID) REFERENCES Laboratory (labID), 
	FOREIGN KEY(projectID) REFERENCES ResearchProject (projectID),
	FOREIGN KEY(experimentID) REFERENCES Experiment (experimentID)
);

CREATE TABLE TestSubject (
	subjectID int NOT NULL,
	subjectSpecies varchar(255) NOT NULL ,
	subjectGender varchar(255) NOT NULL,
	subjectAge int NOT NULL,
	subjectDateTaken datetime2,
	projectID int NOT NULL,
	employeeID int NOT NULL,
	experimentID int NOT NULL,
	PRIMARY KEY(subjectID),
	FOREIGN KEY(projectID) REFERENCES ResearchProject (projectID),
	FOREIGN KEY(employeeID) REFERENCES Employee (employeeID),
	FOREIGN KEY(experimentID) REFERENCES Experiment (experimentID),
);
