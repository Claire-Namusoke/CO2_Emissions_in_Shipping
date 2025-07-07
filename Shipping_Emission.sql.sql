create database CO2_Shipping_Emissions;
create table Emission_by_Vessel (
    [Date] VARCHAR (7)  primary key,
    Reference_area varchar(100) not null,
    Source varchar(255) not null,
    Vessel varchar(100) not null,
   [Year] int not null,
    Month_number int not null,
    [Month] VARCHAR (20) not null,
    Obs_Value FLOAT not null
);

DROP TABLE Emission_by_Vessel;  


BULK INSERT Emission_by_Vessel
FROM 'C:\SQLData\Emission_by_Vessel.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\r\n',
    TABLOCK
);

BULK INSERT Emission_by_Vessel
FROM 'C:\SQLData\Emission_by_Vessel.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '0x0a',  
    CODEPAGE = '65001',     
    TABLOCK
);

select * from Emission_by_Vessel;

-- Clean up the tables
drop table if exists Emission_by_Vessel;
-- Recreate the table with an auto-incrementing primary key

CREATE TABLE Emission_by_Vessel (
    emission_id INT IDENTITY(1,1) PRIMARY KEY,  -- 👈 Auto-incrementing PK
    [Date] VARCHAR(7) NOT NULL,
    Reference_area VARCHAR(100) NOT NULL,
    Source VARCHAR(255) NOT NULL,
    Vessel VARCHAR(100) NOT NULL,
    [Year] INT NOT NULL,
    Month_number INT NOT NULL,
    [Month] VARCHAR(20) NOT NULL,
    Obs_Value FLOAT NOT NULL
);
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;

EXEC sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;

INSERT INTO Emission_by_Vessel ([Date], Reference_area, Source, Vessel, [Year], Month_number, [Month], Obs_Value)
SELECT *
FROM OPENROWSET(
    BULK 'C:\SQLData\Emission_by_Vessel.csv',
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001'
) AS DataFile;


BULK INSERT Emission_by_Vessel
FROM 'C:\SQLData\Emission_by_Vessel.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\r\n',
    TABLOCK
);


SELECT name FROM sys.databases;

USE CO2_Shipping_Emissions;
GO

SELECT name 
FROM sys.tables;

USE CO2_Shipping_Emissions;
GO
SELECT TOP 10 * FROM Emission_by_Vessel;

SELECT TOP 10 * FROM CO2_Shipping_Emissions.dbo.Emission_by_Vessel;

USE CO2_Shipping_Emissions;
GO

CREATE TABLE Emissions_by_Vessel (
    emission_id INT IDENTITY(1,1) PRIMARY KEY,
    [Date] VARCHAR(7) NOT NULL,
    Reference_area VARCHAR(100) NOT NULL,
    Source VARCHAR(255) NOT NULL,
    Vessel VARCHAR(100) NOT NULL,
    [Year] INT NOT NULL,
    Month_number INT NOT NULL,
    [Month] VARCHAR(20) NOT NULL,
    Obs_Value FLOAT NOT NULL
);

USE CO2_Shipping_Emissions;
GO

SELECT  * FROM Emissions_by_Vessel;
SELECT * FROM Emissions_by_Country;
SELECT COUNT(*) FROM Emissions_by_Country;



