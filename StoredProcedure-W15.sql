--Maxwell Rumahorbo
--12S24037
--Sistem Informasi

--Exercise 1
CREATE PROCEDURE sp_Exercise1 
AS 
BEGIN 
 	SELECT CompanyName  
 	FROM Customers  
 	WHERE SUBSTRING (CompanyName, 2, 1) = 'a'; 
	END 
	GO
	
--Menjalankan prosedur
EXEC sp_Exercise1; 

--Exercise 2
Create PROCEDURE sp_Exercise2  
AS  
BEGIN  
    SELECT  
        CompanyName,  
        CONCAT(ContactTitle, ' ', ContactName) AS Contact, 
        COUNT(Orders.OrderID) AS Num_of_Orders  
    FROM Customers 
    JOIN Orders ON Customers.CustomerID = Orders.CustomerID 
    GROUP BY CompanyName, ContactTitle, ContactName; 
END 
GO 

--Menjalankan prosedur
EXEC sp_Exercise2; 

--Exercise 3
CREATE PROCEDURE sp_Exercise3 
AS 
BEGIN 
 	SELECT  
 	 	EmployeeID,  
 	 	Title,  
 	 	CONCAT(FirstName, ' ', LastName) AS 'Employee Name',  
 	 	DATEDIFF(year, BirthDate, GETDATE())  AS Age 
 	FROM Employees; 
END 
GO 

--Menjalankan prosedur
EXEC sp_Exercise3; 

--Exercise 4
CREATE PROCEDURE sp_Exercise4 
    @ContactName nvarchar(255) = null 
AS 
BEGIN 
    SELECT  
        Orders.OrderID,  
        Orders.CustomerID,  
        [Order Details].ProductID,  
        ([Order Details].UnitPrice * [Order Details].Quantity) AS TotalPrice,          Customers.ContactName 
    FROM  
        Orders 
    JOIN  
        Customers ON Orders.CustomerID = Customers.CustomerID 
    JOIN  
        [Order Details] ON Orders.OrderID = [Order Details].OrderID     WHERE  
        (@ContactName IS NULL OR Customers.ContactName = @ContactName); END 

--Menjalankan prosedur
EXEC sp_Exercise4; 
