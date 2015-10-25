CHECKPOINT; DBCC DROPCLEANBUFFERS; 

--- 1.) Create a table in SQL Server with 10 000 000 log entries (date + text).
---		Search in the table by date range. Check the speed (without caching).
CREATE TABLE Cars(
	CarId int NOT NULL PRIMARY KEY IDENTITY,
	Model varchar(100),
	ProductionYear date
)
GO

INSERT INTO Cars(Model, ProductionYear) VALUES ('VW GOLF 5', GETDATE() + 1)
INSERT INTO Cars(Model, ProductionYear) VALUES ('Mercedes k-111', GETDATE()+2)
INSERT INTO Cars(Model, ProductionYear) VALUES ('Dodge Ram', GETDATE()+3)
INSERT INTO Cars(Model, ProductionYear) VALUES ('Aston Martin DB', GETDATE()+4)
INSERT INTO Cars(Model, ProductionYear) VALUES ('Opel Ascona', GETDATE()+5)
INSERT INTO Cars(Model, ProductionYear) VALUES ('Fiat Punto', GETDATE()+6)
INSERT INTO Cars(Model, ProductionYear) VALUES ('Citroen Xsara', GETDATE()+7)
INSERT INTO Cars(Model, ProductionYear) VALUES ('Lexus C3', GETDATE()+8)
INSERT INTO Cars(Model, ProductionYear) VALUES ('BMW Z3', GETDATE()+9)
INSERT INTO Cars(Model, ProductionYear) VALUES ('Tesla', GETDATE()+10)
GO

DECLARE @Counter int = 0
WHILE (SELECT COUNT(*) FROM Cars) < 10000000
BEGIN
	INSERT INTO Cars(Model, ProductionYear)
		SELECT Model + CONVERT(varchar, @Counter), GETDATE() + @Counter 
		FROM Cars
	SET @Counter = @Counter + 1
END
GO
--- time needed for executin of the code above : 3.37 m:ss ; Data space: 599MB ; Total space : 2234MB

--- 2.) Add an index to speed-up the search by date.
--- Test the search speed (after cleaning the cache).

CREATE INDEX IDX_Cars_ProductionYear
ON Cars(ProductionYear)

--- clean the cache
CHECKPOINT; DBCC DROPCLEANBUFFERS;

SELECT * FROM Cars
WHERE ProductionYear BETWEEN GETDATE() AND GETDATE() + 20
--- time needed for executin of the code above : 0.45 m:ss


--- 3.) Add a full text index for the text column. 
---		Try to search with and without the full-text index and compare the speed.                              

CREATE FULLTEXT CATALOG CarModelFullTextCat
WITH ACCENT_SENSITIVITY = OFF

CREATE FULLTEXT INDEX ON Cars(Model)
KEY INDEX PK__Cars__68A0342EE7258D23
ON CarModelFullTextCat
WITH CHANGE_TRACKING AUTO

CHECKPOINT; DBCC DROPCLEANBUFFERS;
SELECT * FROM Cars
WHERE Model LIKE 'BMW%'
GO

CHECKPOINT; DBCC DROPCLEANBUFFERS;
SELECT * FROM Cars
WHERE Model LIKE 'Opel%'
GO

CHECKPOINT; DBCC DROPCLEANBUFFERS; 
SELECT * FROM Cars
WHERE CONTAINS(Model, 'Golf')
GO

CHECKPOINT; DBCC DROPCLEANBUFFERS;
SELECT * FROM Cars
WHERE CONTAINS(Model, 'Dodge')
GO

--- 4.) same tasks in MySQL
