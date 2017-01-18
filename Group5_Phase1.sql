BEGIN TRAN
-- ROLLBACK

-- Bradley Walker --

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

-- End Bradley Walker --

-- Eren Corapcioglu --

-- Creating the main book table in the primary file group (C3)
CREATE TABLE Animal
(
	AnimalID INT IDENTITY(1,1) PRIMARY KEY, -- a surrogate primary key that is automatically counting. (C2)
	AnimalGUID UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), -- Creating a unique identifier (GUID) for this table. (C4)
	AnimalGender CHAR(1), -- creating as a char since we will only want to insert 'M' for male or 'F' for female for consistancy purpose. (C13-c).
	AnimalAge INT NOT NULL CHECK (AnimalAge > 0), -- Animals will always have an age and therefore this field should never be 0 (C6). This field will be averaged based off of animal type (C11).
	AnimalShelterID INT, -- This will be a foreign key. (C8)
	AnimalTypeID INT CHECK (AnimalTypeID > 0) -- This will be a FK (C8). This can never be 0 since all Animals must have a type (C6).
) --ON [PRIMARY];
GO

-- Creating a table to keep track of each animal schedule
CREATE TABLE AnimalSchedule
(
	AnimalScheduleID INT IDENTITY(1,1) PRIMARY KEY,
	AnimalMorningFeedTime TIME NULL, -- this field can be null since not all animals get fed twice a day (C10). This is a TIME field since we want to know the exact time the animal gets fed. (C13-f).
	AnimalEveningFeedTime TIME NULL, -- this field can be null since not all animals get fed twice a day (C10) (See the check constraint below). This is a TIME field since we want to know the exact time the animal gets fed. (C13-f).
	AnimalMorningMedTime TIME NULL, -- this field can be null since not all animals get medication (C10). This is a TIME field since we want to know the exact time the animal gets their meds. (C13-f).
	AnimalEveningMedTime TIME NULL, -- this field can be null since not all animals get medication (C10). This is a TIME field since we want to know the exact time the animal gets their meds. (C13-f).
	AnimalScheduleExtraDetails VARCHAR(MAX),-- This expalins in detail what the animlal schedule is like (C-12).
	AnimalID INT -- This will be a foreign key. (C8)
) --ON Group5FinalProject;
GO

ALTER TABLE AnimalSchedule
ADD CONSTRAINT VerifyFeedTimes CHECK (AnimalMorningFeedTime IS NOT NULL OR AnimalEveningFeedTime IS NOT NULL); -- This constraint says that the animals need to get fed at least once a day. (C7)

-- This is a lookup table to keep track of the different personnel types. This way duplicate personnel types are not entered.
CREATE TABLE PersonnelType
(
	PersonnelTypeID INT IDENTITY(1,1) PRIMARY KEY,
	PersonnelTypeGUID UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), -- Creating a unique identifier (GUID) for this table (C4). This has been set to Deafult NewID to make sure it's always populated if it's not set when inserting into the table (C9).
	PersonnelTypeTitle VARCHAR(100), -- The personnel type title hsould not be more than 100 characters (C13-d).
	PersonnelTypeDesciption VARCHAR(MAX),-- This expalins what the personnel type description in further detail (C12).
	PersonnelTypePurpose VARCHAR(MAX) -- This explains the roles each personnel type is responsbile for (C12).
) --ON Group5FinalProject;
GO

-- This is a lookup table to keep track of the different animal types. This way duplicate animal types are not entered.
CREATE TABLE AnimalType
(
	AnimalTypeID INT IDENTITY(1,1) PRIMARY KEY,
	AnimalTypeGUID UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), -- Creating a unique identifier (GUID) for this table. (C4)
	AnimalType VARCHAR(100), -- The animal type title should not be more than 100 characters.
	AnimalTypeDesciption VARCHAR(MAX),-- This expalins what the animal type description in further detail.
	AnimalTypePurpose VARCHAR(MAX) -- This explains the purpose of each animal type.
) --ON Group5FinalProject;
GO

-- This is a lookup table to keep track of the different customer types. This way duplicate animal types are not entered.
CREATE TABLE CustomerType
(
	CustomerTypeID INT IDENTITY(1,1) PRIMARY KEY,
	CustomerTypeGUID UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), -- Creating a unique identifier (GUID) for this table. (C4)
	CustomerTypePosition VARCHAR(100), -- The customer type position sould not be more than 100 characters.
	CustomerTypeDesciption VARCHAR(MAX),-- This expalins what the customer type description in further detail.
	CustomerTypePurpose VARCHAR(MAX) -- This explains the purpose of each personnel type.
) --ON Group5FinalProject;
GO

-- End Eren Corapcioglu --

-- Kelly Truong -- 

/*Types used: Int, Varchar, Char*/
CREATE TABLE VetClinic (
	ClinicID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	ClinicName VARCHAR(100) NOT NULL,
	ClinicLocation VARCHAR(100) NOT NULL,
	ClinicHours VARCHAR(100) NOT NULL,
	ClinicPhoneNum CHAR(10) NOT NULL,
	ClinicEMail VARCHAR(100) NOT NULL,
	ShelterID INT NOT NULL CHECK (ShelterID > 0)
	CONSTRAINT ShelterID FOREIGN KEY REFERENCES AnimalShelter (ShelterID)
)

/*Types used: Int, Varchar, Char*/
CREATE TABLE Vet (
	VetID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	VetName VARCHAR(100) NOT NULL,
	VetPhoneNum CHAR(10) NOT NULL,
	VetEMail VARCHAR(100) NOT NULL,
	ClinicID INT NOT NULL CHECK (ClinicID > 0)
	CONSTRAINT ClinicID FOREIGN KEY REFERENCES VetClinic (ClinicID)
)

/*Table Vet is created in the primary file group*/
ON [PRIMARY]

/*AniMedCost and LastVisitCost are numeric fields that make sense to be summed to get LastTotalCost
AniMeds and AniIll are varchar(max) fields
Types used: Int, Bit, Varchar, Money, DateTime2*/
CREATE TABLE VetRecords (
	VetRecordsID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	AniShotsUpToDate BIT,
	AniMeds VARCHAR(MAX),
	AniMedsCost MONEY,
/*Default value for illness is that the animal is healthy*/
	AniIll VARCHAR(MAX) DEFAULT 'Animal is healthy.',
	LastVisitDate DATETIME2,
	LastVisitCost MONEY,
	LastTotalCost MONEY,
	VetID INT NOT NULL CHECK (VetID > 0),
	AnimalID INT NOT NULL CHECK (AnimalID > 0)
	CONSTRAINT VetID FOREIGN KEY REFERENCES Vet (VetID)
)
 -- End Kelly Truong
 
 -- Tika Robinson
 
 CREATE TABLE Customers
(
 CustomerID int identity(1, 1) not null primary key
,CFName varchar(20)
,CLName varchar(20)
,CustomerPhoneNumber char(10)
,CustomerEmail varchar (50)
,NumberOfAnimalAdopted  varchar(max) DEFAULT '0'
,NumberofAnimalAbandoned bit
,AnimalID int not null
,CustomerTypeID int not null
)

CREATE TABLE Breeder
(
 BreederID int identity (1,1) not null primary key
,AnimalID int not null
,BfName varchar(20)
,BlName varchar(20)
,BreederPhoneNumber char(10)
,DaycareEmail varchar (50)
)

/*had to add a new column for this table, which was daycare inspection that has a datatype 
datetime2, it specifies when the last time the daycare had been inspected*/
CREATE TABLE DayCareCenter
(
 DaycareID int identity(1,1) not null primary key
 ,DaycareLocation varchar(50)
 ,DaycareName varchar(100)
 ,DaycarePhoneNumber char(10)
 ,DaycareEmail varchar(50)
 ,DaycareInspection datetime2  
 ,ShelterID int not null
)
-- End Tika Robinson

-- Foregin Keys -- Eren Corapcioglu --

-- Adding all the foreign key constraints
-- Add a foreign key on AnimalSchedule.AnimalID to reference Animal.AnimalID
ALTER TABLE AnimalSchedule
ADD CONSTRAINT [FK_AnimalSchedule_Animal_AnimalID]
FOREIGN KEY (AnimalID)
REFERENCES Animal (AnimalID);

-- Add a foreign key on Animal.AnimalTypeID to reference AnimalType.AnimalTypeID.
ALTER TABLE Animal
ADD CONSTRAINT [FK_Animal_AnimalType_AnimalTypeID]
FOREIGN KEY (AnimalTypeID)
REFERENCES AnimalType (AnimalTypeID);

-- Add a foreign key on Animal.AnimalShelterID to reference AnimalShelter.ShelterID
ALTER TABLE Animal
ADD CONSTRAINT [FK_Animal_AnimalShelter_AnimalShelterID]
FOREIGN KEY (AnimalShelterID)
REFERENCES AnimalShelter (ShelterID);

-- Add a foreign key on Personnel.PersonnelTypeID to reference PersonnelType.PersonnelTypeID
ALTER TABLE Personnel
ADD CONSTRAINT [FK_Personnel_PersonnelType_PersonnelTypeID]
FOREIGN KEY (PersonnelTypeID)
REFERENCES PersonnelType (PersonnelTypeID);

-- Add a foreign key on Personnel.PersonnelTypeID to reference PersonnelType.PersonnelTypeID
ALTER TABLE Customers
ADD CONSTRAINT [FK_Customers_CustomerType_CustomerTypeID]
FOREIGN KEY (CustomerTypeID)
REFERENCES CustomerType (CustomerTypeID);

-- Add a foreign key on Personnel.PersonnelTypeID to reference PersonnelType.PersonnelTypeID
ALTER TABLE Customers
ADD CONSTRAINT [FK_Customers_Animal_AnimalID]
FOREIGN KEY (AnimalID)
REFERENCES Animal (AnimalID);

-- Add a foreign key on Personnel.PersonnelTypeID to reference PersonnelType.PersonnelTypeID
ALTER TABLE Breeder
ADD CONSTRAINT [FK_Breeder_Animal_AnimalID]
FOREIGN KEY (AnimalID)
REFERENCES Animal (AnimalID);

-- Add a foreign key on Personnel.PersonnelTypeID to reference PersonnelType.PersonnelTypeID
ALTER TABLE DayCareCenter
ADD CONSTRAINT [FK_DayCareCenter_AnimalShelter_ShelterID]
FOREIGN KEY (ShelterID)
REFERENCES AnimalShelter (ShelterID);

-- Add a foreign key on Personnel.PersonnelTypeID to reference PersonnelType.PersonnelTypeID
ALTER TABLE VetRecords
ADD CONSTRAINT [FK_VetRecords_Animal_AnimalID]
FOREIGN KEY (AnimalID)
REFERENCES Animal (AnimalID);

-- End Foregin Keys -- Eren Corapcioglu --

ROLLBACK