SELECT * 
FROM Departments

SELECT Name
FROM Departments

SELECT FirstName + ' ' + LastName as FullName, Salary as Salary
FROM Employees

SELECT FirstName + '.' + LastName + '@telerik.com' as 'Full Email Addresses'
FROM Employees

SELECT DISTINCT Salary
FROM Employees
ORDER BY Employees.Salary DESC

SELECT *
FROM Employees
WHERE JobTitle = 'Stocker'

SELECT FirstName + ' ' + LastName as FullName
FROM Employees
WHERE FirstName Like 'SA%'

SELECT FirstName + ' ' + LastName as FullName
FROM Employees
WHERE LastName Like '%ei%'

SELECT FirstName + ' ' + LastName as 'Full Name', Salary as Salary
FROM Employees
WHERE Salary BETWEEN 20000 AND 30000

SELECT FirstName + ' ' + LastName as 'Full Name', Salary as Salary
FROM Employees
WHERE Salary IN (25000, 14000, 12500, 23600)
ORDER BY FirstName ASC

SELECT FirstName + ' ' + LastName as 'Full Name'
FROM Employees
WHERE ManagerID IS Null

SELECT FirstName + ' ' + LastName as 'Full Name', Salary as Salary
FROM Employees
WHERE Salary > 50000
ORDER BY Salary DESC

SELECT TOP 5 FirstName, LastName, Salary as "TOP 5 Salary"
FROM Employees
ORDER BY Salary DESC

SELECT FirstName, LastName, AddressText
FROM Employees
INNER JOIN Addresses
ON Employees.AddressID = Addresses.AddressID

SELECT FirstName, LastName, AddressText
FROM Employees e, Addresses a
WHERE e.AddressID = a.AddressID

SELECT e.FirstName + ' ' + e.LastName AS Employee, m.FirstName + ' ' + m.LastName AS Manager
FROM Employees e LEFT OUTER JOIN Employees m
ON e.ManagerID = m.EmployeeID

SELECT e.FirstName + ' ' + e.LastName AS Employee, 
m.FirstName + ' ' + m.LastName AS Manager,
a.AddressText AS 'Current Address'
FROM Employees e INNER JOIN Employees m ON e.ManagerID = m.EmployeeID
JOIN Addresses a ON e.AddressID = a.AddressID

SELECT Name
FROM Departments
UNION
SELECT Name
FROM Towns

SELECT m.FirstName + ' ' + m.LastName AS Manager, e.FirstName + ' ' + e.LastName AS Employee
FROM Employees m RIGHT OUTER JOIN Employees e
ON e.ManagerID = m.EmployeeID

SELECT e.FirstName + ' ' + e.LastName AS Employee, m.FirstName + ' ' + m.LastName AS Manager
FROM Employees e LEFT OUTER JOIN Employees m
ON e.ManagerID = m.EmployeeID

SELECT e.FirstName + ' ' + e.LastName AS 'Employee Name', d.Name AS Department, e.HireDate 
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.Name IN ('Sales', 'Finance')
AND YEAR(e.HireDate) BETWEEN 1995 AND 2005