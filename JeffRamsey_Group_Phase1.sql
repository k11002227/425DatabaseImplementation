--- Group Project Phase 1
--- CSC 425/625
--- Jeff Ramsey

CREATE TABLE Events (
        EventID INT IDENTITY(1,1) PRIMARY KEY, 
        EventLoacation char(20) DEFAULT NULL, 
        EventDescription varchar(100) NULL, 
        EventMoneyRaised money NULL,
        EventVolunteerID int NOT NULL, 
        EventShelterID int NOT NULL
) ON [PRIMARY]

CREATE TABLE Donations (
        DonorID INT IDENTITY(1,1) PRIMARY KEY, 
        DonarPhoneNumber  varchar(60)  NOT NULL,
        DonorEmail varchar(256) NOT NULL,
        DonorName varchar(256) NOT NULL,
        DonorCompany varchar(256) NOT NULL,
        DonationItems varchar(25) NOT NULL
);

CREATE TABLE ShelterNeeds (
        ShelterNeedsID INT IDENTITY(1,1) PRIMARY KEY, 
        ShelterNeedsDescription text NULL
);

ALTER TABLE Donations
ADD CONSTRAINT [FK_Donations_AnimalShelter_DonorShelterID]
FOREIGN KEY (DonorShelterID)
REFERENCES AnimalShelter (ShelterID);


ALTER TABLE ShelterNeeds
ADD CONSTRAINT [FK_ShelterNeeds_AnimalShelter_ShelterNeedsID]
FOREIGN KEY (ShelterNeedsID)
REFERENCES AnimalShelter (ShelterID);