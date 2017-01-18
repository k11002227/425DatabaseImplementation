/*Phase 3
Create SQL scrips to create stored procedures; include the codes to test and to create*/

/*add data to one table from data values passed in the parameters*/
CREATE PROCEDURE insertIntoAnimalShelter (	@ShelterAddress		VARCHAR(35)
									,		@ShelterName		VARCHAR(30)
									,		@ShelterPhoneNumber	VARCHAR(10)
									,		@ShelterEmail		VARCHAR(50))
AS
BEGIN
	INSERT INTO AnimalShelter (
		ShelterAddress
	,	ShelterName
	,	ShelterPhoneNumber
	,	ShelterEmail)
	VALUES (
		@ShelterAddress
	,	@ShelterName
	,	@ShelterPhoneNumber
	,	@ShelterEmail);
END

EXEC insertIntoAnimalShelter	'987 Other Connection Lane'
							,	'Shells By The Shelter Shelter'
							,	'5761321654'
							,	'SBTSS@group5.com';
SELECT *
FROM AnimalShelter;
GO
/*add data to two tables using one stored procedure from data values passed in the parameters*/
CREATE PROCEDURE insertIntoPersonnelTypeAndPersonnel (	@PersonnelTypeTitle		VARCHAR(100)
													,	@PersonnelFName			VARCHAR(30)
													,	@PersonnelLName			VARCHAR(30)
													,	@PersonnelPhoneNumber	VARCHAR(10)
													,	@PersonnelEmail			VARCHAR(50)
													,	@PersonnelSalary		MONEY
														@PersonnelTypeID)		INT(
AS
BEGIN
	INSERT INTO PersonnelType (
		PersonnelTypeTitle)
	VALUES (
		@PersonnelTypeTitle)
	INSERT INTO Personnel (
		PersonnelFName
	,	PersonnelLName
	,	PersonnelPhoneNumber
	,	PersonnelEmail
	,	PersonnelSalary
	,	PersonnelTypeID)
	VALUES (
		@PersonnelFName
	,	@PersonnelLName
	,	@PersonnelPhoneNumber
	,	@PersonnelEmail
	,	@PersonnelSalary
	,	@PersonnelTypeID)
END

EXEC insertIntoProductTypeAndProduct	'Paper Shredder'
									,	'Otis'
									,	'Marsh'
									,	'4131684685'
									,	'ProfessionalPapaShredda@aol.com'
									,	9600.50
									,	6;
SELECT *
FROM PersonnelType
FULL OUTER JOIN Personnel
ON ProductType.PersonnelTypeID=Personnel.PersonnelTypeID
ORDER BY ProdName, ProdTypeID;
GO
/*iterate through a table using a cursor and change a value on some rows based on a test*/
CREATE PROCEDURE updateCustomerEmail
AS	
BEGIN
	DECLARE updateCustomerEmailCursor CURSOR LOCAL FOR SELECT CustomerEmail FROM Customers;
	OPEN updateCustomerEmailCursor;
	DECLARE @currentEmail VARCHAR(50);
	FETCH NEXT FROM updateCustomerEmailCursor INTO @currentEmail;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @currentEmail IS NULL
		BEGIN
			UPDATE Customers
			SET ReviewContent = 'No email address was provided'
			WHERE CURRENT OF updateCustomerEmailCursor
		END
		FETCH NEXT FROM updateCustomerEmailCursor INTO @currentEmail;
	END
	CLOSE updateCustomerEmailCursor
END;

EXEC updateCustomerEmail;
SELECT *
FROM Customers;
GO
/*retreive data from all ONE table using XML AUTO*/
CREATE PROCEDURE selectDayCareCenter
AS
BEGIN
	SELECT *
	FROM DayCareCenter
	FOR XML AUTO;
END

EXEC selectDayCareCenter;
SELECT *
FROM DayCareCenter;
GO
/*retrieve data from all ONE table using XML EXPLICIT*/
CREATE PROCEDURE selectAnimal
AS
BEGIN
	SELECT 1 AS Tag, NULL AS Parent	, AnimalID AS [Animal!1!AnimalID]
									, AnimalGUID AS [Animal!1!AnimalGUID]
									, AnimalGender AS [Animal!1!AnimalGender]
									, AnimalAge AS [Animal!1!AnimalAge]
									, AnimalShelterID AS [Animal!1!AnimalShelterID]
									, AnimalTypeID AS [Animal!1!AnimalTypeID]
	FROM Animal
	FOR XML EXPLICIT;
END

EXEC selectAnimal;
SELECT *
FROM Animal;
GO
/*stored procedure that uses dynamic SQL*/
CREATE PROCEDURE updateAnimalTypeDescrip (@newAnimalTypeDescription VARCHAR(MAX))
AS
BEGIN
	UPDATE AnimalType
	SET AnimalTypeDescription += @newAnimalTypeDescription;
END

EXEC updateAnimalTypeDescription 'Males are aggressive to other males during mating season';
SELECT AnimalTypeDescription
FROM AnimalType;
GO
/*stored procedure that returns records from one of the tables based on a filter parameter*/
CREATE PROCEDURE selectBreeders (@filterBreederID INT)
AS
BEGIN
	SELECT *
	FROM Breeder
	WHERE BreederID <= @filterProdTypeID;
END

EXEC selectBreeders 3;
SELECT *
FROM Breeder;
GO
/*stored procedure that uses a return value/output parameter*/
CREATE PROCEDURE selectMeds (	@VetRecordsID INT
							,	@result VARCHAR(MAX) OUTPUT)
AS
BEGIN
	SELECT AniMeds
	FROM VetRecords
	WHERE VetRecordsID = @VetRecordsID;
	RETURN;
END

DECLARE @printableResult VARCHAR(MAX);					
EXECUTE selectMeds 1, @result = @printableResult OUTPUT;
print @printableResult 
SELECT VetRecordsID, AniMeds
FROM VetRecords;
GO
/*stored procedure that accepts an optional input*/
CREATE PROCEDURE updateBreederPhoneNumber (	@BreederID				INT
										,	@NewBreederPhoneNumber	CHAR(10) = NULL)
AS
BEGIN
	UPDATE Breeder
	SET BreederPhoneNumber = @NewBreederPhoneNumber
	WHERE BreederID = @BreederID;
END
		
EXECUTE updateBreederPhoneNumber 1;
SELECT BreederID, BreederPhoneNumber
FROM Breeder;
GO
