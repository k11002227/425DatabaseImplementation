CREATE DATABASE Group5FinalProject
-- Creating the first Primary file (A1)
ON PRIMARY
(
	NAME = 'Group5P1',
	FILENAME = 'C:\CSCProjectsS16\ECorapcioglu\Group5P1.mdf',
	SIZE = 20MB, -- min/starting size for the file
	MAXSIZE = 30MB -- max size for the file
),
-- Creating the second Primary file (A1)
(
	NAME = 'Group5P2',
	FILENAME = 'C:\CSCProjectsS16\ECorapcioglu\Group5P2.mdf',
	SIZE = 20MB, -- min/starting size for the file
	MAXSIZE = 30MB -- max size for the file
),
-- Creating the one Secondary file (A2)
FILEGROUP Group5Secondary
(
	NAME = 'Group5S1',
	FILENAME = 'C:\CSCProjectsS16\ECorapcioglu\Group5S1.ndf',
	SIZE = 500KB, -- min/starting size for the file
	MAXSIZE = 10MB, -- max size for the file
	FILEGROWTH = 1MB -- the file will grow 1MB at a time
)
-- Creating the log file (A3)
LOG ON
(
	NAME = 'Group5Log',
	FILENAME = 'C:\CSCProjectsS16\ECorapcioglu\Group5Log.ldf',
	SIZE = 10MB, -- min/starting size for the file
	MAXSIZE = 20MB, -- max size for the file
	FILEGROWTH = 1% -- the file will grow 1% at a time
);

-- run this to see what the default path for creating files are.
--SELECT SERVERPROPERTY('InstanceDefaultDataPath')

--select SERVERPROPERTY('InstanceDefaultLogPath')