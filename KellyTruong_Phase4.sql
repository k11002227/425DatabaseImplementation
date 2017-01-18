/*Phase 4 --Part B
Create a SQL user*/
CREATE LOGIN Adaline WITH PASSWORD = 'timeliness';
CREATE USER Adaline FOR LOGIN Adaline;
GO

/*Phase 4 --Part C
Give a user access to a database*/
USE master;
GRANT SELECT ON Group5FinalProject TO Adaline;
USE DATABASE Group5FinalProject;
GO

/*Phase 4 --Part D
Grant a user access to execute a stored procedure*/
GRANT EXECUTE ON OBJECT::insertIntoAnimalShelter
    TO Adaline;
GO

/*Phase 4 --Part E
Revoke a users rights to a table*/
REVOKE SELECT ON AnimalShelter TO Adaline;
GO

/*Phase 4 --Part F
Deny a user access to a table*/
DENY SELECT ON OBJECT::Breeder TO Adaline;
GO

/*Removes Users created
DROP USER Adaline;
DROP LOGIN Adaline;*/