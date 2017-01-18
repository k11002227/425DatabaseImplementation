--USE DATABASE Group5FinalProject;
--GO

-- Creating the main book table in the primary file group (C3)
CREATE TABLE Animal
(
	AnimalID INT IDENTITY(1,1) PRIMARY KEY, -- a surrogate primary key that is automatically counting. (C2)
	AnimalGUID UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), -- Creating a unique identifier (GUID) for this table. (C4)
	AnimalGender CHAR(1), -- creating as a char since we will only want to insert 'M' for male or 'F' for female for consistancy purpose. (C13-c).
	AnimalAge INT NOT NULL CHECK (AnimalAge > 0), -- Animals will always have an age and therefore this field should never be 0 (C6). This field will be averaged based off of animal type (C11).
	AnimalShelterID INT, -- This will be a foreign key. (C8)
	AnimalTypeID INT CHECK (AnimalTypeID > 0) -- This will be a FK (C8). This can never be 0 since all Animals must have a type (C6).
) ON [PRIMARY];
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
) ON Group5FinalProject;
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
) ON Group5FinalProject;
GO

-- This is a lookup table to keep track of the different animal types. This way duplicate animal types are not entered.
CREATE TABLE AnimalType
(
	AnimalTypeID INT IDENTITY(1,1) PRIMARY KEY,
	AnimalTypeGUID UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), -- Creating a unique identifier (GUID) for this table. (C4)
	AnimalType VARCHAR(100), -- The animal type title should not be more than 100 characters.
	AnimalTypeDesciption VARCHAR(MAX),-- This expalins what the animal type description in further detail.
	AnimalTypePurpose VARCHAR(MAX) -- This explains the purpose of each animal type.
) ON Group5FinalProject;
GO

-- This is a lookup table to keep track of the different customer types. This way duplicate animal types are not entered.
CREATE TABLE CustomerType
(
	CustomerTypeID INT IDENTITY(1,1) PRIMARY KEY,
	CustomerTypeGUID UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), -- Creating a unique identifier (GUID) for this table. (C4)
	CustomerTypePosition VARCHAR(100), -- The customer type position sould not be more than 100 characters.
	CustomerTypeDesciption VARCHAR(MAX),-- This expalins what the customer type description in further detail.
	CustomerTypePurpose VARCHAR(MAX) -- This explains the purpose of each personnel type.
) ON Group5FinalProject;
GO

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
ALTER TABLE Personnel
ADD CONSTRAINT [FK_Personnel_PersonnelType_PersonnelTypeID]
FOREIGN KEY (PersonnelTypeID)
REFERENCES PersonnelType (PersonnelTypeID);

---- Eren Phase 2 Part A

--INSERT INTO AnimalShelter (ShelterName, ShelterAddress, ShelterPhoneNumber, ShelterEmail)
--VALUES	('Shelter 1', '123 Main Street', '1231231234', 'shelter1@gmail.com'),
--		('Shelter 2', '123 Main Street', '1231231234', 'shelter1@gmail.com'),
--		('Shelter 3', '123 Main Street', '1231231234', 'shelter1@gmail.com'),
--		('Shelter 4', '123 Main Street', '1231231234', 'shelter1@gmail.com'),
--		('Shelter 5', '123 Main Street', '1231231234', 'shelter1@gmail.com'),
--		('Shelter 6', '123 Main Street', '1231231234', 'shelter1@gmail.com'),
--		('Shelter 7', '123 Main Street', '1231231234', 'shelter1@gmail.com');

INSERT INTO AnimalType (AnimalType, AnimalTypeDesciption, AnimalTypePurpose)
VALUES	('Cat', 'Small, typically furry, carnivorous mammal.', 'Purpose of house cats are to be pets to the common family.'),
		('Dog', 'Varying in size, typically furry, carnivorous mammal.', 'Purpose of dog is to be mans best friend and the sweetest addition to a family as a pet.'),
		('Turtle', 'Small, typically not furry, with a hard shell. These creatures can live in the water or on land.', 'Smaller turtles have been known for a house hold pet.'),
		('Bird', 'Varying in size, typically with feathers, most fly with their wings.', 'Some birds, such as parrots, have been known to be a family pet.'),
		('Hamster', 'Small, typically furry, type of rodent.', 'Purpose of hamsters are to be a low maitenenace pet to the family.'),
		('Rabbit', 'Ranges from very sall to small, typically furry, typically eats veggies.', 'Purpose of rabbits are to be a low maitenenace pet to the family.'),
		('Lizzard', 'Varying in size, typically not furry, can be poisionous.', 'Purpose of some lizzards are to be a low maitenenace pet to the family.');

INSERT INTO Animal (AnimalGender, AnimalAge, AnimalShelterID, AnimalTypeID)
VALUES	('F', 7, 1, 1),
		('M', 1, 2, 2),
		('M', 6, 3, 4),
		('F', 9, 4, 3),
		('M', 12, 5, 7),
		('F', 2, 4, 6),
		('F', 4, 5, 2);
		
INSERT INTO AnimalSchedule (AnimalMorningFeedTime, AnimalEveningFeedTime, AnimalMorningMedTime, AnimalEveningMedTime, AnimalScheduleExtraDetails, AnimalID)
VALUES	('09:00:00', '17:00:00', '07:00:00', '18:00:00', 'This cat needs to get meds twice a day at the specified time.', 1),
		(NULL, '16:00:00', NULL, NULL, 'This dog does not need meds currently.', 2),
		('07:00:00', '16:00:00', '07:00:00', '16:00:00', 'This turtle needs to get meds twice a day at the specified time.', 3),
		('09:00:00', NULL, NULL, '12:00:00', 'This bird needs to get meds twice a day at the specified time.', 4),
		('08:00:00', '16:00:00', '07:00:00', '18:00:00', 'This rabbit needs to get meds twice a day at the specified time.', 6),
		(NULL, '17:00:00', NULL, NULL, 'This dog does not need meds currently.', 2),
		('06:00:00', '16:00:00', '06:00:00', '16:00:00', 'This cat needs to get meds twice a day at the specified time.', 1);
		
-- This is a lookup table to keep track of the different personnel types. This way duplicate personnel types are not entered.
INSERT INTO PersonnelType (PersonnelTypeTitle, PersonnelTypeDesciption, PersonnelTypePurpose)
VALUES	('Empolyee', 'Employee of a shelter', 'To work and take care of animals at a shelter.'),
		('Volunteer', 'Volunteer of a shelter', 'To volunteer and take care of animals at a shelter.'),
		('Donor', 'Donor to shelters', 'To donate different needs to shelters.'),
		('Manager', 'Manager of a shelter', 'To be in charge of each shelter.'),
		('Owner', 'Owner of a shelter', 'To own a shelter.')

-- This is a lookup table to keep track of the different customer types. This way duplicate animal types are not entered.
INSERT INTO CustomerType (CustomerTypePosition,CustomerTypeDesciption, CustomerTypePurpose)
VALUES	('Adopter', 'A customer who can adopt pets.', 'To adopt a pet from a shelter'),
		('Abandoner', 'A customer who cannot adopt pets.', 'To not be able to adopt pets from a shelter'),
		('Breeder', 'A customer breeds dogs.', 'To breed pets for a shelter'),
		('Breeder-In Progress', 'A customer who is in training to breed dogs.', 'To train to breed pets to a shelter'),
		('Foster', 'A customer fosters pets.', 'To foster dogs until they are adopted.');
		
-- Eren Phase 2 Part B 
SELECT DISTINCT
	at.AnimalType AS AnimalType ,
	AVG(a.AnimalAge) AS AverageAnimalAge -- Count the number of editors each publisher has (based off of the GROUP BY).
FROM Animal a
FULL OUTER JOIN AnimalType at ON a.AnimalTypeID = at.AnimalTypeID -- B13
WHERE a.AnimalTypeID = 2
GROUP BY AnimalType; -- B10

-- Create a new table, tblTestAnimal, using SELECT INTO
SELECT 
	a.*, -- Select all values from Animal
	at.AnimalTypeDesciption,
	at.AnimalTypePurpose
INTO tblTestAnimal -- B4
FROM Animal a
RIGHT OUTER JOIN AnimalType at ON a.AnimalTypeID = at.AnimalTypeID -- B14
WHERE at.AnimalTypeID IN (2, 3, 4); -- B19

SELECT * FROM tblTestAnimal

DROP TABLE tblTestAnimal
