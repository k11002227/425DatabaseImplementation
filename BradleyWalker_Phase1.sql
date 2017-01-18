USE master
-- CREATE DATABASE temporary123
-- DROP DATABASE temporary123
USE temporary123

CREATE TABLE AnimalShelter
(
	ShelterID			INT					NOT NULL	PRIMARY KEY		IDENTITY(1, 1)
,	ShelterAddress		VARCHAR(30)			NOT NULL
,	ShelterName			VARCHAR(30)			NOT NULL
,	ShelterPhoneNumber	VARCHAR(10)			NOT NULL
,	ShelterEmail		VARCHAR(50)			NOT NULL
,	ShelterUniqueID		UNIQUEIDENTIFIER	NOT NULL	DEFAULT NEWID()
,	TIMESTAMP
)
ON [PRIMARY]
GO

CREATE TABLE ShelterInspectionSchedule
(
	ShelterInspectionID		INT			NOT NULL	PRIMARY KEY			IDENTITY(1, 1)
,	LastInspectionDate		DATETIME2				DEFAULT GETDATE()
,	NextInspectionDate		DATETIME2	NOT NULL
,	PassLastInspection		BIT			NOT NULL
,	ShelterID INT REFERENCES AnimalShelter(ShelterID) NOT NULL
,	CONSTRAINT CK_Next_Date CHECK(NextInspectionDate > GETDATE())
,	TIMESTAMP
)
GO

CREATE TABLE Personnel
(
	PersonnelID				INT				NOT NULL	PRIMARY KEY		IDENTITY(1, 1)
,	PersonnelFName			VARCHAR(30)		NOT NULL
,	PersonnelLName			VARCHAR(30)		NOT NULL
,	PersonnelPhoneNumber	VARCHAR(10)		NOT NULL
,	PersonnelEmail			VARCHAR(50)		NOT NULL
,	PersonnelSalary			MONEY			NOT NULL	DEFAULT 0.00
,	PersonnelTypeID INT NOT NULL--REFERENCES PersonnelType(PersonnelTypeID) NOT NULL
,	CONSTRAINT CK_Salary CHECK(PersonnelSalary > 0.00)
,	TIMESTAMP
)
GO