/*Kelly Truong Phase 1 --Part C

Create three tables with minium features:
Have surrogate primary keys
Have automatically counting IDs
Have at least two foreign keys
Have at least four fields each
Have at least one filed that allows nulls
Have check constraints on foreign keys to make sure IDs are greater than 0
One of the following types: Integer, Bit, Char, Varchar, Money, DateTime2*/

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
	CONSTRAINT VetID FOREIGN KEY REFERENCES Vet (VetID),
	CONSTRAINT AnimalID FOREIGN KEY REFERENCES Animal (AnimalID)
)

/*Kelly Truong Phase 2 --Part A

Insert at least 5 rows/set of values into each table*/
INSERT INTO VetClinic (
	ClinicName
,	ClinicLocation
,	ClinicHours
,	ClinicPhoneNum
,	ClinicEMail
,	ShelterID)
VALUES
(	'Jenna Clinic'
,	'4040 Quim Street Shreveport LA 71115'
,	'Monday to Saturday 7AM to 7PM; Closed Sundays'
,	'2092890520'
,	'JennaClinic@Zulfiqar.com'
,	1);
INSERT INTO VetClinic (
	ClinicName
,	ClinicLocation
,	ClinicHours
,	ClinicPhoneNum
,	ClinicEMail
,	ShelterID)
VALUES
(	'Darell Glen Sebastinana Clinic'
,	'111 Zaro Lane Orange City CA  90009'
,	'Monday to Saturday Closed; Sundays 7AM to 7PM'
,	'4764654646'
,	'DGSebastinanaClinic@DGSC.com'
,	2);
INSERT INTO VetClinic (
	ClinicName
,	ClinicLocation
,	ClinicHours
,	ClinicPhoneNum
,	ClinicEMail
,	ShelterID)
VALUES
(	'Ivaylo Adad Clinic'
,	'35 Domitille Parkway Phoenix AZ 85003'
,	'Monday to Sundays 8AM to 5PM'
,	'6921340961'
,	'IvayloClinic@Adad.com'
,	3);
INSERT INTO VetClinic (
	ClinicName
,	ClinicLocation
,	ClinicHours
,	ClinicPhoneNum
,	ClinicEMail
,	ShelterID)
VALUES
(	'Yohna Clinic'
,	'666 Holy Lane Cathaoir AK 99502'
,	'All Day Sundays'
,	'6666666666'
,	'YohnaClinic@Meshullam.com'
,	4);
INSERT INTO VetClinic (
	ClinicName
,	ClinicLocation
,	ClinicHours
,	ClinicPhoneNum
,	ClinicEMail
,	ShelterID)
VALUES
(	'Dag Annushka Clinic'
,	'365 Goyathlay Avenue Aloe Vera FL 32004'
,	'Open 24 Hours'
,	'8498509904'
,	'DagAnnushkaClinic@DAGClinic.com'
,	5);
INSERT INTO Vet (
	VetName
,	VetPhoneNum
,	VetEMail
,	ClinicID)
VALUES
(	'Fadia Torgny'
,	'6546541654'
,	'F.Torgny@gmail.com'
,	1);
INSERT INTO Vet (
	VetName
,	VetPhoneNum
,	VetEMail
,	ClinicID)
VALUES
(	'Baltasar Pyrrhus'
,	'9646541651'
,	'Pyrrhus928@bellsouth.com'
,	2);
INSERT INTO Vet (
	VetName
,	VetPhoneNum
,	VetEMail
,	ClinicID)
VALUES
(	'Heidi Yehudah'
,	'6456541213'
,	'Y.Heidi.Vet@aol.com'
,	3);
INSERT INTO Vet (
	VetName
,	VetPhoneNum
,	VetEMail
,	ClinicID)
VALUES
(	'Ida Yosef'
,	'7651321063'
,	'Yosef.Ida22y@gmail.com'
,	4);
INSERT INTO Vet (
	VetName
,	VetPhoneNum
,	VetEMail
,	ClinicID)
VALUES
(	'Margareta Jacklyn'
,	'6463132125'
,	'MJacklyn455@yahoo.com'
,	5);
INSERT INTO VetRecords (
	AniShotsUpToDate
,	AniMeds
,	AniMedsCost
,	AniIll
,	LastVisitDate
,	LastVisitCost
,	LastTotalCost
,	VetID
,	AnimalID)
VALUES
(	1
,	'Spazortab'
,	44.44
,	'Scatoses'
,	04042004
,	200.00
,	244.44
,	5
,	1);
INSERT INTO VetRecords (
	AniShotsUpToDate
,	AniMeds
,	AniMedsCost
,	AniIll
,	LastVisitDate
,	LastVisitCost
,	LastTotalCost
,	VetID
,	AnimalID)
VALUES
(	0
,	'Swazidem, Crapacet'
,	69.96
,	'Boozdraination, Xanosa'
,	06091996
,	200.00
,	269.96
,	4
,	2);
INSERT INTO VetRecords (
	AniShotsUpToDate
,	AniMeds
,	AniMedsCost
,	AniIll
,	LastVisitDate
,	LastVisitCost
,	LastTotalCost
,	VetID
,	AnimalID)
VALUES
(	1
,	'Nosture, Skizestra, Spazitor'
,	1111.11
,	'Dragnerfation, Blovjerkemia, Fartfenasis Deficiency'
,	11112011
,	600.00
,	1766.11
,	3
,	3);
INSERT INTO VetRecords (
	AniShotsUpToDate
,	AniMeds
,	AniMedsCost
,	AniIll
,	LastVisitDate
,	LastVisitCost
,	LastTotalCost
,	VetID
,	AnimalID)
VALUES
(	0
,	'Pixpippa, Xannox, Blazosec, Gustiva'
,	7171.71
,	'Slammushasia, Ragscatasia, Nihdipposa Disease, Boxphalaphy Palsy'
,	07152015
,	200.00
,	7371.71
,	2
,	4);
INSERT INTO VetRecords (
	AniShotsUpToDate
,	AniMeds
,	AniMedsCost
,	AniIll
,	LastVisitDate
,	LastVisitCost
,	LastTotalCost
,	VetID
,	AnimalID)
VALUES
(	NULL
,	NULL
,	NULL
,	NULL
,	NULL
,	NULL
,	NULL
,	1
,	5);

/*Kelly Truong Phase 2 --Part B

Create SQL SELECT STATEMENTS that demonstrates at least one JOIN and one more item*/

/*FULL OUTER JOIN
Shows which vet works at which clinic (ordered by clinic)*/
SELECT VetClinic.ClinicName AS Clinic, Vet.VetName AS Veterinarian
FROM VetClinic
FULL OUTER JOIN Vet
ON VetClinic.ClinicID=Vet.ClinicID
ORDER BY VetClinic.ClinicID

/*NOT EXISTS
Shows which animal has not had their shots up to date*/
SELECT AnimalID
FROM VetRecords
WHERE NOT EXISTS
    (SELECT * 
     FROM VetRecords
	 WHERE AniShotsUpToDate = 1)