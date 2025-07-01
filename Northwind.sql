--Maxwell Rumahorbo
--12S24037
--Sistem Informasi

--Exercise 1

--Northwind
IF DB_ID('Northwind') IS NULL
    CREATE DATABASE Northwind;
GO

USE Northwind;
GO

--Membuat stored procedure GetCompaniesWithSecondCharA
CREATE PROCEDURE GetCompaniesWithSecondCharA
AS
BEGIN
    SELECT CompanyName
    FROM Customers
    WHERE SUBSTRING(CompanyName, 2, 1) = 'a'
    ORDER BY CompanyName;
END;

--Menjalankan prosedur
EXEC GetCompaniesWithSecondCharA;

--Exercise 2

--Membuat stored procedure GetAllCustomerDataOrdered
CREATE PROCEDURE GetAllCustomerDataOrdered
AS
BEGIN
    SELECT 
        c.CompanyName,
        c.ContactName,
        COUNT(o.OrderID) AS total_orders
    FROM 
        Customers c
    LEFT JOIN 
        Orders o ON c.CustomerID = o.CustomerID
    GROUP BY 
        c.CompanyName, c.ContactName
    ORDER BY 
        c.CompanyName ASC, COUNT(o.OrderID) ASC;
END;

--Menjalankan prosedur
EXEC GetAllCustomerDataOrdered;

--Exercise 3

--Membuat stored procedure GetEmployeeDataWithAge
CREATE PROCEDURE GetEmployeeDataWithAge
AS
BEGIN
    SELECT 
        EmployeeID,
        Title,
        FirstName + ' ' + LastName AS EmployeeName,
        DATEDIFF(YEAR, BirthDate, GETDATE()) 
            - CASE 
                WHEN DATEADD(YEAR, DATEDIFF(YEAR, BirthDate, GETDATE()), BirthDate) > GETDATE() 
                THEN 1 ELSE 0 
              END AS Age
    FROM Employees;
END;

--Menjalankan prosedur
EXEC GetEmployeeDataWithAge;

--Exercise 4

--Membuat stored procedure GetOrdersByContactName
CREATE PROCEDURE GetOrdersByContactName
    @ContactName NVARCHAR(100) = NULL
AS
BEGIN
    SELECT 
        o.OrderID,
        o.CustomerID,
        od.ProductID,
        SUM(od.UnitPrice * od.Quantity) AS TotalPrice,
        c.ContactName
    FROM 
        Orders o
    JOIN [Order Details] od ON o.OrderID = od.OrderID
    JOIN Customers c ON o.CustomerID = c.CustomerID
    WHERE 
        (@ContactName IS NULL OR c.ContactName = @ContactName)
    GROUP BY 
        o.OrderID, o.CustomerID, od.ProductID, c.ContactName
    ORDER BY 
        o.OrderID;
END;

--Menampilkan semua data order:
EXEC GetOrdersByContactName;

--Menampilkan order untuk contact name tertentu
EXEC GetOrdersByContactName @ContactName = 'Karin Josephs';

