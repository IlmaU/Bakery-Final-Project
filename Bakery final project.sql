--Change the data type of Date_manufactured from datetime to date
ALTER TABLE main
ALTER COLUMN Date_manufactured date;

--Create a Products table
SELECT Product_id, Product_name, Price, Date_manufactured, Quantity_in_stock INTO Products
FROM main

--Update the price of each item

UPDATE main
SET Price=
	CASE 
	WHEN Product_name = 'French Bread' THEN 2.00
	WHEN Product_name = 'Italian Bread' THEN 2.50
	WHEN Product_name = 'Butter Croissants' THEN 6.00
	WHEN Product_name = 'Chocolate Croissants' THEN 7.00
	WHEN Product_name = 'Vanilla Pastry' THEN 4.00
	WHEN Product_name = 'Chocolate Pastry' THEN 4.00
	WHEN Product_name = 'Tiramisu Pastry' THEN 4.50
	WHEN Product_name = 'Strawberry Shortcake' THEN 12.00
	WHEN Product_name = 'Black Forest Cake' THEN 15.00
	WHEN Product_name = 'Chocolate Mocha Cake' THEN 17.50
	WHEN Product_name = 'Lemon Cake' THEN 10.00
	END
SELECT * FROM Products

--Create an Employee table
CREATE TABLE Employee (
	Employee_ID INT NOT NULL,
	Employee_name VARCHAR(50),
	Employee_phone INT NULL,
	Employee_email VARCHAR(50)
);
ALTER TABLE Employee
ALTER COLUMN Employee_phone VARCHAR(20);
--Insert values in Emploeee table
INSERT INTO Employee VALUES (42,'Eustacia Hamshar',9764297026,'ehamshar0@amazon.com');
INSERT INTO Employee VALUES (35,'Drud Flemming',8734029911,'dflemming1@vimeo.com');
INSERT INTO Employee VALUES (26,'Teodoor Liven',1848757421,'tliven2@cam.ac.uk');
INSERT INTO Employee VALUES (21,'Nancee Buesden',6687064081,'nbuesden3@microsoft.com');
INSERT INTO Employee VALUES (42,'Bernadette Sommersett',5931831107,'bsommersett4@is.gd');
INSERT INTO Employee VALUES (26,'Sigismond Melby',7037614780,'smelby5@blogspot.com');
INSERT INTO Employee VALUES (53,'Olivier Comerford',6927761736,'ocomerford6@slideshare.net');
INSERT INTO Employee VALUES (50,'Byran Prentice',6357560841,'bprentice7@who.net');

SELECT * FROM Employee

--Create Customer table
SELECT Customer_FirstName, Customer_LastName, Customer_email INTO Customers
FROM main
SELECT * FROM Customers

--Create Orders  Table
SELECT Order_id, Order_date, Product_id, Product_name, Date_manufactured, Price, Quantity_Ordered, Customer_FirstName, Customer_LastName INTO Orders
FROM main
--Changing datatype from datetime to date
ALTER TABLE Orders
ALTER COLUMN Order_date date;
--Arranging the table with the newest orders first
SELECT * FROM Orders
ORDER BY Order_date DESC; 

--Create a STORED PROCEDURE to remove entries with Order_date before Date_manufactured. 
CREATE PROCEDURE Remove_orders_before_date_manufactured
AS
	DELETE FROM Orders
	WHERE Order_date > Date_manufactured;
GO

SELECT * FROM Orders
EXECUTE Remove_orders_before_date_manufactured
GO

--Create a VIEW that returns a table that lists all the products with quantities less than or equal to 4
CREATE VIEW vLowStock
AS
SELECT * FROM Products
WHERE Quantity_in_stock <= 4;
GO

SELECT * FROM vLowStock


--Create a FUNCTION to bring up order details from the Order table by looking up a Customer's last name
ALTER FUNCTION CustomerOrder (@name varchar(50))
RETURNS TABLE
AS
RETURN(
		SELECT * FROM Orders
		WHERE Customer_LastName = @name 
);
GO
SELECT * FROM CustomerOrder('Luby');


--Create a cleanup script to delete the database
DROP DATABASE Bakery

--Create a database backup
BACKUP DATABASE Bakery
TO DISK ='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\Bakery.bak';