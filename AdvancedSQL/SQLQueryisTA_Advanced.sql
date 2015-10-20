--- 1.) Employees with the minimal salary
SELECT FirstName, LastName, Salary
FROM Employees
WHERE Salary = 
	(SELECT MIN(Salary) FROM Employees)

--- 1b.) using a DECLARE statement for the first task
DECLARE @MinimalPaid Int = (SELECT MIN(Salary) FROM Employees)
SELECT CONCAT(e.FirstName, ' ', e.LastName, ': ', Salary) AS "Minimal Paid Employees"
FROM Employees e
WHERE Salary = @MinimalPaid

--- 2.) Write a SQL query to find the names and salaries of the employees that have a salary 
---		that is up to 10% higher than the minimal salary for the company.
SELECT FirstName, LastName, Salary
FROM Employees
WHERE Salary < 
	(SELECT MIN(Salary) + (MIN(Salary) * 0.1) FROM Employees)

--- 2b.)
DECLARE @LowestTenPercentSalaries int = (SELECT (MIN(Salary) + MIN(Salary) * 0.1) FROM Employees)
SELECT FirstName, LastName, Salary
FROM Employees
WHERE Salary <= @LowestTenPercentSalaries

--- 3.)Write a SQL query to find the full name, salary and department of the employees 
---		that take the minimal salary in their department.
---		Use a nested SELECT statement.
SELECT e.FirstName + ' ' + e.LastName AS FullName, e.Salary, d.Name AS 'Department Name'
FROM Employees e
JOIN Departments d
	ON e.DepartmentID = d.DepartmentID
WHERE Salary =	
	(SELECT MIN(Salary) FROM Employees em
	WHERE em.DepartmentID = d.DepartmentID)
	ORDER BY d.Name ASC, FullName ASC

--- 4.) Write a SQL query to find the average salary in the department #1.
SELECT ROUND(AVG(e.Salary),2) as 'Average Salary in Department #1'
FROM Employees e
WHERE e.DepartmentID = 1

--- 5.) Write a SQL query to find the average salary in the "Sales" department.
SELECT ROUND(AVG(e.Salary),2) as 'Average Salary in Department Sales'
FROM Employees e
JOIN Departments d
	ON e.DepartmentID = d.DepartmentID
WHERE d.Name = 'Sales'

--- 6.) Write a SQL query to find the number of employees in the "Sales" department.
SELECT COUNT(e.FirstName) AS 'Sales Employees Count'
FROM Employees e
JOIN Departments d
	ON e.DepartmentID = d.DepartmentID
WHERE d.Name = 'Sales'

--- 7.) Write a SQL query to find the number of all employees that have manager.
SELECT COUNT(e.FirstName) AS 'Employees with Manager'
FROM Employees e
WHERE e.ManagerID IS NOT NULL

--- 8.) Write a SQL query to find the number of all employees that have no manager.
SELECT COUNT(e.FirstName) AS 'Employees without Manager'
FROM Employees e
WHERE e.ManagerID IS NULL

--- 9.) Write a SQL query to find all departments and the average salary for each of them.
SELECT d.Name AS DepartmentName, ROUND(AVG(e.Salary), 2) AS AverageSalary
FROM Employees e
JOIN Departments d
	ON e.DepartmentID = d.DepartmentID
GROUP BY d.Name
ORDER BY AverageSalary DESC

--- 10.) Write a SQL query to find the count of all employees in each department and for each town.
SELECT COUNT(e.EmployeeID) AS EmployeesCount, d.Name, t.Name
FROM Employees e
JOIN Departments d
	ON e.DepartmentID = d.DepartmentID
JOIN Addresses a
	ON e.AddressID = a.AddressID
JOIN Towns t
	ON a.TownID = t.TownID
GROUP BY d.Name, t.Name
ORDER BY EmployeesCount DESC

--- 10b.) using UNION but the results are duplicating data (for departments and towns)
SELECT COUNT(e.EmployeeId) as EmployeeCount, d.Name
FROM Employees e 
JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
GROUP BY d.Name
UNION
SELECT COUNT(e.EmployeeId) as EmployeeCount, t.Name
FROM Employees e 
JOIN Addresses a
    ON e.AddressID = a.AddressID
JOIN Towns t
    ON a.TownID = t.TownID
GROUP BY t.Name
ORDER BY EmployeeCount DESC

--- 11.) Write a SQL query to find all managers that have exactly 5 employees. Display their first name and last name.
SELECT e.FirstName + ' ' + e.LastName AS ManagerName, COUNT(em.EmployeeID) as EmployeesCount
FROM Employees e
JOIN Employees em
	ON e.EmployeeID = em.ManagerID
GROUP BY e.FirstName, e.LastName
HAVING COUNT(e.EmployeeID) = 5
ORDER BY ManagerName ASC

--- 12.) Write a SQL query to find all employees along with their managers. 
---		For employees that do not have manager display the value "(no manager)".
SELECT ISNULL(em.FirstName + ' ' + em.LastName , 'No manager') as Manager,
	   ISNULL(e.FirstName + ' ' + e.LastName, 'No employees') as Employee	   
FROM Employees em
LEFT JOIN Employees e
	ON e.EmployeeID = em.ManagerID

--- 13.) Write a SQL query to find the names of all employees whose last name is exactly 5 characters long. 
---		Use the built-in LEN(str) function.
SELECT e.FirstName + ' ' + e.LastName AS FullName
FROM Employees e
WHERE LEN(e.LastName) = 5

--- 14.) Write a SQL query to display the current date and time in the following format 
----	"day.month.year hour:minutes:seconds:milliseconds".
SELECT FORMAT(GETDATE(), 'dd.MM.yyyy hh:mm:ss:ms')

--- 14b.) second variant using Convert and 113(Europian time standart)
SELECT CONVERT(VARCHAR(24),GETDATE(),113)

--- 15.) Write a SQL statement to create a table Users. Users should have username, password, full name and last login time.
---	ok	Choose appropriate data types for the table fields. Define a primary key column with a primary key constraint.
---	ok	Define the primary key column as identity to facilitate inserting records.
---	ok	Define unique constraint to avoid repeating usernames.
---	ok	Define a check constraint to ensure the password is at least 5 characters long.
CREATE TABLE Users (
	UserId Int IDENTITY,
	Username nvarchar(50) NOT NULL,
	Password nvarchar(50) NOT NULL CHECK (LEN(Password) > 5),
	Fullname nvarchar(100) NOT NULL,
	LastLogin DATETIME,
	CONSTRAINT PK_Users PRIMARY KEY(UserId),
	CONSTRAINT UK_Username UNIQUE(Username)
)
GO

--- 16.) Write a SQL statement to create a view that displays the users from the Users 
---		table that have been in the system today. Test if the view works correctly.
CREATE VIEW UsersLoggedToday AS 
	SELECT u.Username
	FROM Users AS u
	WHERE DATEDIFF(day, LastLogin, GETDATE()) = 0
GO

--- 17.) Write a SQL statement to create a table Groups. 
---		Groups should have unique name (use unique constraint).
---		Define primary key and identity column.
CREATE TABLE Groups (
	GroupId Int IDENTITY,
	Name nvarchar(50) NOT NULL,
	CONSTRAINT PK_Groups PRIMARY KEY(GroupId),
	CONSTRAINT UK_Name UNIQUE(Name)
)
GO

--- 18.) Write a SQL statement to add a column GroupID to the table Users.
---	ok	Fill some data in this new column and as well in the `Groups table.
---	ok	Write a SQL statement to add a foreign key constraint between tables Users and Groups tables.
ALTER TABLE Users
	ADD GroupId Int
GO

ALTER TABLE Users
	ADD CONSTRAINT PK_Users_Groups
	FOREIGN KEY (GroupId)
	REFERENCES Groups(GroupId)
GO

--- 19.) Write SQL statements to insert several records in the Users and Groups tables.
INSERT INTO Groups(Name) VALUES
('Gruop1'),
('Gruop2'),
('Gruop3'),
('Gruop4'),
('Gruop5')

--- 19.) Write SQL statements to insert several records in the Users and Groups tables.
INSERT INTO Users(Username, Password, Fullname, LastLogin) VALUES
 ('testUsername1', 'testPassword1', 'testFullName1', '2010-3-06 00:00:00'),
 ('testUsername2', 'testPassword2', 'testFullName2', '2010-3-07 00:00:00'),
 ('testUsername3', 'testPassword3', 'testFullName3', '2010-3-08 00:00:00'),
 ('testUsername4', 'testPassword4', 'testFullName4', '2010-3-09 00:00:00'),
 ('testUsername5', 'testPassword5', 'testFullName5', '2010-3-10 00:00:00'),
 ('testUsername6', 'testPassword6', 'testFullName6', '2010-3-11 00:00:00'),
 ('testUsername7', 'testPassword7', 'testFullName7', '2010-3-12 00:00:00'),
 ('testUsername8', 'testPassword8', 'testFullName8', '2010-3-13 00:00:00'),
 ('testUsername9', 'testPassword9', 'testFullName9', '2010-3-14 00:00:00')

 --- 20.) Write SQL statements to update some of the records in the Users and Groups tables.
UPDATE Users
SET Username = REPLACE(Username, 'test', 'TEST')
WHERE UserId IS NOT NULL

--- 21.) Write SQL statements to delete some of the records from the Users and Groups tables.
DELETE FROM Users
WHERE LEN(Username) < 6

DELETE FROM Groups
WHERE Name LIKE '%Alkoholics%'

--- 22.) Write SQL statements to insert in the Users table the names of all employees from the Employees table.
---		Combine the first and last names as a full name.
---		For username use the first letter of the first name + the last name (in lowercase).
---		Use the same for the password, and NULL for last login time.
INSERT INTO Users(Username, Fullname, Password)
	(SELECT LOWER(LEFT(e.FirstName, 1) +  e.LastName),
			e.FirstName + ' ' + e.LastName,
			LOWER(LEFT(e.FirstName, 1) +  e.LastName)
	FROM Employees e)
GO

--- 23.) Write a SQL statement that changes the password to NULL 
---		for all users that have not been in the system since 10.03.2010.
CREATE TABLE UsersWithNullPass (
    UserId Int IDENTITY,
    Username nvarchar(50),
    Password nvarchar(50),
    FullName nvarchar(50),
    LastLoginTime DATETIME,
    CONSTRAINT PK_UsersWithNullPass PRIMARY KEY(UserId),
    CONSTRAINT UQ_Username UNIQUE(Username),
) 
GO

INSERT INTO UsersWithNullPass VALUES
 ('nickname1', 'qwerty1', 'Unnamed1', '2010-3-06 00:00:00'),
 ('nickname2', 'qwerty2', 'Unnamed2', '2010-3-07 00:00:00'),
 ('nickname3', 'qwerty3', 'Unnamed3', '2010-3-08 00:00:00'),
 ('nickname4', 'qwerty4', 'Unnamed4', '2010-3-09 00:00:00'),
 ('nickname5', 'qwerty5', 'Unnamed5', '2010-3-10 00:00:00'),
 ('nickname6', 'qwerty6', 'Unnamed6', '2010-3-11 00:00:00'),
 ('nickname7', 'qwerty7', 'Unnamed7', '2010-3-12 00:00:00'),
 ('nickname8', 'qwerty8', 'Unnamed8', '2010-3-13 00:00:00'),
 ('nickname9', 'qwerty9', 'Unnamed9', '2010-3-14 00:00:00')
 GO

 UPDATE UsersWithNullPass
 SET Password = NULL
 WHERE DATEDIFF(day, LastLoginTime, '2010-3-10') > 0

 --- 24.) Write a SQL statement that deletes all users without passwords (NULL password).
 DELETE 
 FROM UsersWithNullPass 
 WHERE Password IS NULL

 --- 25.) Write a SQL query to display the average employee salary by department and job title.
 SELECT d.Name, ROUND(AVG(e.Salary),2) as AverageSalary, e.JobTitle
 FROM Employees e
 JOIN Departments d
	ON e.DepartmentID = d.DepartmentID
 GROUP BY d.Name, e.JobTitle
 ORDER BY AverageSalary DEsc

 --- 26.) Write a SQL query to display the minimal employee salary by department 
 ---	and job title along with the name of some of the employees that take it.
  SELECT d.Name, ROUND(MIN(e.Salary),2) as AverageSalary, e.JobTitle, MAX(e.FirstName + ' ' + e.LastName) AS RandomEmployee 
 FROM Employees e
 JOIN Departments d
	ON e.DepartmentID = d.DepartmentID
 GROUP BY d.Name, e.JobTitle
 ORDER BY AverageSalary DESC

 --- 27.) Write a SQL query to display the town where maximal number of employees work.
 SELECT TOP 1 t.Name, COUNT(e.EmployeeID) as NumberOfEmployees
 FROM Employees e
 JOIN Addresses a
	ON e.AddressID = a.AddressID
 JOIN Towns t
	ON t.TownID = a.TownID
 GROUP BY t.Name
 
 --- 28.) Write a SQL query to display the number of managers from each town.
 SELECT t.Name AS Town, COUNT(e.EmployeeID) AS ManagerCount
 FROM Employees e
 JOIN Addresses a
	ON e.AddressID = a.AddressID
 JOIN Towns t
	ON a.TownID = t.TownID
 GROUP BY t.Name

 --- 29. Write a SQL to create table WorkHours to store work reports 
--- for each employee (employee id, date, task, hours, comments). 
--- Don't forget to define  identity, primary key and appropriate foreign key. 
---
--- Issue few SQL statements to insert, update and delete of some data in the table.
--- Define a table WorkHoursLogs to track all changes in the WorkHours table with triggers.
---
--- For each change keep the old record data, the new record data and the 
--- command (insert / update / delete).

--- TABLE: WorkHours
CREATE TABLE WorkHours (
    WorkReportId int IDENTITY,
    EmployeeId Int NOT NULL,
    OnDate DATETIME NOT NULL,
    Task nvarchar(256) NOT NULL,
    Hours Int NOT NULL,
    Comments nvarchar(256),
    CONSTRAINT PK_Id PRIMARY KEY(WorkReportId),
    CONSTRAINT FK_Employees_WorkHours 
        FOREIGN KEY (EmployeeId)
        REFERENCES Employees(EmployeeId)
) 
GO

--- INSERT
DECLARE @counter int;
SET @counter = 20;
WHILE @counter > 0
BEGIN
    INSERT INTO WorkHours(EmployeeId, OnDate, Task, [Hours])
    VALUES (@counter, GETDATE(), 'TASK: ' + CONVERT(varchar(10), @counter), @counter)
    SET @counter = @counter - 1
END

--- UPDATE
UPDATE WorkHours
SET Comments = 'Work hard or go home!'
WHERE [Hours] > 10

--- DELETE
DELETE FROM WorkHours
WHERE EmployeeId IN (1, 3, 5, 7, 13)

--- TABLE: WorkHoursLogs
CREATE TABLE WorkHoursLogs (
    WorkLogId int,
    EmployeeId Int NOT NULL,
    OnDate DATETIME NOT NULL,
    Task nvarchar(256) NOT NULL,
    Hours Int NOT NULL,
    Comments nvarchar(256),
    [Action] nvarchar(50) NOT NULL,
    CONSTRAINT FK_Employees_WorkHoursLogs
        FOREIGN KEY (EmployeeId)
        REFERENCES Employees(EmployeeId),
    CONSTRAINT [CC_WorkReportsLogs] CHECK ([Action] IN ('Insert', 'Delete', 'DeleteUpdate', 'InsertUpdate'))
) 
GO

--- TRIGGER FOR INSERT
CREATE TRIGGER tr_InsertWorkReports ON WorkHours FOR INSERT
AS
INSERT INTO WorkHoursLogs(WorkLogId, EmployeeId, OnDate, Task, [Hours], Comments, [Action])
    SELECT WorkReportId, EmployeeID, OnDate, Task, [Hours], Comments, 'Insert'
    FROM inserted
GO

--- TRIGGER FOR DELETE
CREATE TRIGGER tr_DeleteWorkReports ON WorkHours FOR DELETE
AS
INSERT INTO WorkHoursLogs(WorkLogId, EmployeeId, OnDate, Task, [Hours], Comments, [Action])
    SELECT WorkReportId, EmployeeID, OnDate, Task, [Hours], Comments, 'Delete'
    FROM deleted
GO

--- TRIGGER FOR UPDATE
CREATE TRIGGER tr_UpdateWorkReports ON WorkHours FOR UPDATE
AS
INSERT INTO WorkHoursLogs(WorkLogId, EmployeeId, OnDate, Task, [Hours], Comments, [Action])
    SELECT WorkReportId, EmployeeID, OnDate, Task, [Hours], Comments, 'InsertUpdate'
    FROM inserted

INSERT INTO WorkHoursLogs(WorkLogId, EmployeeId, OnDate, Task, [Hours], Comments, [Action])
    SELECT WorkReportId, EmployeeID, OnDate, Task, [Hours], Comments, 'DeleteUpdate'
    FROM deleted
GO

--- TEST TRIGGERS
DELETE FROM WorkHoursLogs

INSERT INTO WorkHours(EmployeeId, OnDate, Task, [Hours])
VALUES (25, GETDATE(), 'TASK: 25', 25)

DELETE FROM WorkHours
WHERE EmployeeId = 25

UPDATE WorkHours
SET Comments = 'Updated'
WHERE EmployeeId = 2

--- 30. Start a database transaction, delete all employees from 
--- the 'Sales' department along with all dependent records from 
--- the pother tables. At the end rollback the transaction.

BEGIN TRANSACTION

ALTER TABLE Departments
DROP CONSTRAINT FK_Departments_Employees
GO

DELETE e FROM Employees e
JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
WHERE d.Name = 'Sales'

ROLLBACK TRANSACTION
--- COMMIT TRANSACTION

--- 31. Start a database transaction and drop the table EmployeesProjects.
--- Now how you could restore back the lost table data?

BEGIN TRANSACTION

DROP TABLE EmployeesProjects

ROLLBACK TRANSACTION
--- COMMIT TRANSACTION

--- 32. Find how to use temporary tables in SQL Server. Using temporary 
--- tables backup all records from EmployeesProjects and restore them back 
--- after dropping and re-creating the table.

BEGIN TRANSACTION

SELECT * 
INTO #TempEmployeesProjects  --- Create new table
FROM EmployeesProjects

DROP TABLE EmployeesProjects

SELECT * 
INTO EmployeesProjects --- Create new table
FROM #TempEmployeesProjects;

DROP TABLE #TempEmployeesProjects

ROLLBACK TRANSACTION
--- COMMIT TRANSACTION
