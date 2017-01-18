
/*Create database nameed mr for martika robinson*/
--CREATE DATABASE mr;

/*Create three tables*/
/*created new columns, elaborated names for first name and last name*/
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
,constraint AnimalID foreign key references Animal (AnimalID)
,constraint CustomerTypeID foreign key references CustomerType (CustomerTypeID)
)

CREATE TABLE Breeder
(
 BreederID int identity (1,1) not null primary key
,AnimalID int not null
,BfName varchar(20)
,BlName varchar(20)
,BreederPhoneNumber char(10)
,DaycareEmail varchar (50)
,constraint AnimalID foreign key references Animal (AnimalID)
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
 ,constraint ShelterID foreign key references AnimalShelter (ShelterID)
)

/*Sql scripts 5 rows inserted for tables above*/
/*dummy data for table customers*/

INSERT INTO Customers VALUES
(
 ''
,Aston 
,Williams
,3184256678
,aWilliams@yahoo.com
,''
,'0'
,''
,''
)

INSERT INTO Customers VALUES
(
 ''
,Bureny 
,Macintosh
,2144256678
,bMacintosh@yahoo.com
,'8'
,'0'
,''
,''
)

INSERT INTO Customers VALUES
(
 ''
,Casper
,Ghost
,3054256678
,cGhost@gmail.com
,'4'
,'1'
,''
,''
)

INSERT INTO Customers VALUES
(
 ''
,deston 
,Williams
,6054256678
,dWilliams@aol.com
,'2'
,'0'
,''
,''
)

INSERT INTO Customers VALUES
(
 ''
,Mark
,Suburns
,3186240001
,msuburns@yahoo.com
,'0'
,'0'
,''
,''
)

/*  Insert dummy data for  breeder
 */

INSERT INTO Breeder VALUES
(
 ''
 ,''
 ,Timothy
 ,Howard
 ,3182556412
 ,t1howard@gmail.com
)

INSERT INTO Breeder VALUES
(
 ''
 ,''
 ,Kimothy
 ,Howard
 ,3187256412
 ,k2howard@gmail.com
)

INSERT INTO Breeder VALUES
(
 ''
 ,''
 ,Anthony 
 ,Dewars
 ,3187556412
 ,a3dewars@yahoo.com
)

INSERT INTO Breeder VALUES
(
 ''
 ,''
 ,Brandi
 ,Williams
 ,3185556412
 ,b4williams@gmail.com
)

INSERT INTO Breeder VALUES
(
 ''
 ,''
 ,Mark
 ,Davidson
 ,3184026412
 ,m5davidson@aol.com
)
/* Create dummy data for dayCareCenter*/

INSERT INTO DayCareCenter VALUES
(
  ''
 ,344 Camberton Drive
 ,Alll DogsGoTo Heaven 
 ,3182142562
 ,allDogsGoToHeaven@gmail.com
 ,January 4, 2016 
 ,''
)

INSERT INTO DayCareCenter VALUES
(
  ''
 ,154 Camhall Drive
 ,Dog Place
 ,3185642534
 ,dogPlace@gmail.com
 ,January 10, 2016 
 ,''
)

INSERT INTO DayCareCenter VALUES
(
  ''
 ,658 Emelton Drive
 ,Stay number 1  
 ,3184122562
 ,stayNumber1@gmail.com
 ,Febuary 4, 2016 
 ,''
)

INSERT INTO DayCareCenter VALUES
(
  ''
 ,534 Meritt Drive
 ,Number 1
 ,3182142500
 ,number1@yahoo.com
 ,March 4, 2016 
 ,''
)

INSERT INTO DayCareCenter VALUES
(
  ''
 ,122 Almonst Drive
 ,Dog town 
 ,3182142501
 ,dogTown@yahoo.com
 ,October 11, 20115
 ,''
)

/*creating sql select statements that demonstrate at least one join and one more item from the list*/
select * from Customers
select * from CustomerType
select customerName, customerPhoneNumber, CustomerType
from Customers
inner join CustomerType
on CustmerType.customerTypeID=Customers.CustomerID;