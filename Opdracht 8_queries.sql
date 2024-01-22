--SQL_Drop_Create_opdracht8.sql

DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Televisions;
DROP TABLE IF EXISTS RemoteControllers;
DROP TABLE IF EXISTS CIModules;
DROP TABLE IF EXISTS WallBrachets;
DROP TABLE IF EXISTS Televisions_WallBrackets;


-- Products Table
CREATE TABLE Products
(
ProductID SERIAL PRIMARY KEY,
ProductName VARCHAR(50) not null Unique,
Brand VARCHAR(50) not null,
Price FLOAT not null,
CurrentStock INT not null,
Sold INT not null	
);

-- TV's Table
CREATE TABLE Televisions
(
TelevisionID SERIAL PRIMARY KEY,
TelevisionType VARCHAR(50), 
Available CHAR(5) not null,
RefreshRate CHAR(5) not null,
ScreeType CHAR(10) not null,
ProductID int not null,
RemoteControllerID int not null,
CIModuleID int not null
);

-- RemoteControllers Table
CREATE TABLE RemoteControllers
(
RemoteControllerID SERIAL PRIMARY KEY,
CompatibleWith VARCHAR(50) not null,
BatteryType VARCHAR(50) not null,
ProductID int not null
);

-- CIModules Table
CREATE TABLE CIModules
(
CIModuleID SERIAL PRIMARY KEY,
ProductID int not null
);

-- WallBrachets Table
CREATE TABLE WallBrackets
(
WallBracketID SERIAL PRIMARY KEY,
Adjustible boolean not null,
ProductID int not null
);

-- Televisions_WallBrackets Table
CREATE TABLE Televisions_WallBrackets
(
Television_WallBracketID SERIAL PRIMARY KEY,
TelevisionID INT not null,
WallBracketID INT not null
);





--SQL_Constraints_opdracht8.sql

-- Relatie Televisions - Products
ALTER TABLE Televisions
ADD CONSTRAINT FK_Televisions_Products
FOREIGN KEY (ProductID) REFERENCES Products (ProductID);

-- Relatie Televisions - RemoteControllers
ALTER TABLE Televisions
ADD CONSTRAINT FK_Televisions_RemoteControllers
FOREIGN KEY (RemoteControllerID) REFERENCES RemoteControllers (RemoteControllerID);

-- Relatie Televisions - CIModules
ALTER TABLE Televisions
ADD CONSTRAINT FK_Televisions_CIModules
FOREIGN KEY (CIModuleID) REFERENCES CIModules (CIModuleID);;

-- Relatie RemoteControllers - Products
ALTER TABLE RemoteControllers
ADD CONSTRAINT FK_RemoteControllers_Products
FOREIGN KEY (ProductID) REFERENCES Products (ProductID);

-- Relatie WallBrackets - Products
ALTER TABLE WallBrackets
ADD CONSTRAINT FK_WallBrackets_Products
FOREIGN KEY (ProductID) REFERENCES Products (ProductID);


-- Relatie Televisions_WallBrackets - Televisions
ALTER TABLE Televisions_WallBrackets
ADD CONSTRAINT FK_Televisions_WallBrackets_Televisions
FOREIGN KEY (TelevisionID) REFERENCES Televisions (TelevisionID);

-- Relatie Televisions_WallBrackets - WallBrackets
ALTER TABLE Televisions_WallBrackets
ADD CONSTRAINT FK_Televisions_WallBrackets_WallBrackets
FOREIGN KEY (WallBracketID) REFERENCES WallBrackets (WallBracketID);





--SQL_INSERTS_opdracht8.sql

INSERT INTO Products (ProductName, Brand, Price, CurrentStock, Sold  ) VALUES ('TV1', 'Samsung', 1150, 5, 3);
INSERT INTO Products (ProductName, Brand, Price, CurrentStock, Sold  ) VALUES ('TV2', 'Nokia', 1130, 4, 5);
INSERT INTO Products (ProductName, Brand, Price, CurrentStock, Sold  ) VALUES ('TV3', 'Samsung', 1330, 5, 5);
INSERT INTO Products (ProductName, Brand, Price, CurrentStock, Sold  ) VALUES ('RemoteController1', 'Samsung', 50, 5, 3);
INSERT INTO Products (ProductName, Brand, Price, CurrentStock, Sold  ) VALUES ('RemoteController2', 'Nokia', 60, 3, 5);
INSERT INTO Products (ProductName, Brand, Price, CurrentStock, Sold  ) VALUES ('CIModule1', 'Samsung', 120, 2, 5);
INSERT INTO Products (ProductName, Brand, Price, CurrentStock, Sold  ) VALUES ('CIModule2', 'Nokia', 150, 3, 1);
INSERT INTO Products (ProductName, Brand, Price, CurrentStock, Sold  ) VALUES ('WallBracket1', 'Samsung', 50, 43, 4);
INSERT INTO Products (ProductName, Brand, Price, CurrentStock, Sold  ) VALUES ('WallBracket2', 'Nokia', 60, 33, 0);


INSERT INTO Televisions (TelevisionType, Available, RefreshRate, ScreeType, ProductID, RemoteControllerID, CIModuleID ) VALUES ('Samsung', 'yes',
60, 'Plasma', 1, 1, 1);
INSERT INTO Televisions (TelevisionType, Available, RefreshRate, ScreeType, ProductID, RemoteControllerID, CIModuleID ) VALUES ('Nokia', 'yes',
120, 'LED', 2, 2, 2);
INSERT INTO Televisions (TelevisionType, Available, RefreshRate, ScreeType, ProductID, RemoteControllerID, CIModuleID ) VALUES ('Samsung', 'yes',
80, 'CLED', 3, 1, 1);





INSERT INTO RemoteControllers (CompatibleWith, BatteryType, ProductID) VALUES ('Samsung',
'AAA', 4);
INSERT INTO RemoteControllers (CompatibleWith, BatteryType, ProductID) VALUES ('Nokia',
'AA', 5);





INSERT INTO CIModules (ProductID) VALUES (6);
INSERT INTO CIModules (ProductID) VALUES (7);



INSERT INTO WallBrackets (Adjustible, ProductID) VALUES ('yes',
8);
INSERT INTO WallBrackets (Adjustible, ProductID) VALUES ('no',
9);


INSERT INTO Televisions_WallBrackets (TelevisionID, WallBracketID) VALUES (1, 1);
INSERT INTO Televisions_WallBrackets (TelevisionID, WallBracketID) VALUES (1, 2);
INSERT INTO Televisions_WallBrackets (TelevisionID, WallBracketID) VALUES (2, 1);
INSERT INTO Televisions_WallBrackets (TelevisionID, WallBracketID) VALUES (2, 2);
INSERT INTO Televisions_WallBrackets (TelevisionID, WallBracketID) VALUES (3, 1);
INSERT INTO Televisions_WallBrackets (TelevisionID, WallBracketID) VALUES (3, 2);





--SQL_Ophalen_data_opdracht8.sql


select pr.productname as tvproductname, pr.brand, tv.refreshrate,

(select productname from products where productname in
 (select productname from products where productid = rc.productid)) as remotename

 ,rc.batterytype, 

(select productname from products where productname in
 (select productname from products where productid = ci.productid)) as cimodulename


from products pr


inner join televisions tv on pr.productid = tv.productid
inner join remotecontrollers rc on tv.remotecontrollerid = rc.remotecontrollerid
inner join cimodules ci on tv.cimoduleid = ci.cimoduleid
where tv.available = 'yes'


----------------------