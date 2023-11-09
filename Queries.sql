use DB_Project;

/* -- 1. For each category of Employee, count the number of employees in that category, 
 -- and the average salary of that category. 
SELECT CASE 
	WHEN E.EmployeeID IN (SELECT EmployeeID FROM Manager) THEN 'Manager' 
	WHEN E.EmployeeID IN (SELECT EmployeeID FROM Floor_Staff) THEN 'Floor Staff' 
    WHEN E.EmployeeID IN (SELECT EmployeeID FROM Cashier) THEN 'Cashier' 
    END AS Employee_Category, COUNT(*) AS Number_of_Employees, 
	AVG(Salary) AS Average_Salary FROM Employee E GROUP BY Employee_Category;
-- 2. Find the average number of orders placed by Customer. 
-- SELECT AVG(num_orders) AS Average_Num_Orders 
-- FROM (SELECT CustomerID, COUNT(*) 
-- AS num_orders FROM Places_Order
-- GROUP BY CustomerID) c;

SELECT COUNT(OrderID)/COUNT(DISTINCT CustomerID) AS Avg_Orders
FROM Places_Order;

-- 3. Find all the customers who purchased the Popular-Product. 
SELECT DISTINCT C.CustomerID
FROM Customer C, Ordered_Product OP JOIN Places_Order PO ON OP.OrderID = PO.OrderiD
WHERE C.CustomerID = PO.CustomerID AND OP.ProductID IN (SELECT ProductID From Popular_Product)
GROUP BY C.CustomerID;


-- 4. Find the store that has most different products in stock. 
SELECT P.StoreID, COUNT(DISTINCT P.ProductID) AS num_products 
FROM Products P
GROUP BY P.StoreID 
ORDER BY num_products DESC LIMIT 1;

SELECT S.StoreID, S.Store_type, S.Store_Location, COUNT(DISTINCT P.ProductID) AS num_products 
FROM Products P JOIN Store S ON P.StoreID = S.StoreID
GROUP BY P.StoreID 
HAVING num_products = (
  SELECT MAX(product_count)
  FROM (
    SELECT COUNT(DISTINCT P.ProductID) AS product_count
    FROM Products P
    INNER JOIN Store S ON P.StoreID = S.StoreID
    GROUP BY P.StoreID
  ) AS counts
);


-- 5. Find the floor staff who has taken charge of all the floors in the past 1 week.
SELECT FS.EmployeeID, COUNT(DISTINCT F.Floor) AS num_floors 
FROM Floor_Log F 
JOIN Floor_Staff FS ON F.FloorStaffID = FS.EmployeeID 
WHERE F.Work_Date >= DATE_SUB(CURDATE(), INTERVAL 1 WEEK) 
GROUP BY FS.EmployeeID 
HAVING COUNT(DISTINCT F.Floor) = (SELECT COUNT(DISTINCT Store_Location) FROM Store);


-- 6. For each product, list all the stores selling it, and the price of the product at the stores.
SELECT pr.Name AS ProductName, s.StoreID, s.Store_Location AS StoreLocation, pr.Price AS Price 
FROM Products pr JOIN Store s ON pr.StoreID = s.StoreID 
ORDER BY pr.Name;


-- 7. Find the floor that have the most number of stores located. 
SELECT Store_Location, COUNT(StoreID) AS num_stores 
FROM Store 
GROUP BY Store_Location 
ORDER BY num_stores DESC LIMIT 1;


-- 8. List the schedule of the Gold-Store.
SELECT S.StoreID, S.Open_Time, S.Close_Time
FROM Store S, Gold_Store G
WHERE S.StoreID = G.StoreID;

-- 9. Find the store that produces the most amount of sale in the past 1 week. 
SELECT O.StoreID, SUM(OP.Quantity * OP.Price) AS TotalSale 
FROM Places_Order O JOIN Ordered_Product OP ON O.OrderID = op.OrderID 
WHERE O.Created_Time >= DATE_SUB(NOW(), INTERVAL 1 WEEK) 
GROUP BY O.StoreID 
ORDER BY TotalSale DESC LIMIT 1;


-- 10. Find the employee who supervises the most number of floor staffs
SELECT ManagerID, COUNT(EmployeeID) AS Total_Staff
FROM Floor_Staff
GROUP BY ManagerID
ORDER BY Total_Staff DESC LIMIT 1;
*/

SELECT * FROM Person;
SELECT * FROM Person_Phone_Numbers;
SELECT * FROM Employee;
SELECT * FROM Customer;
SELECT * FROM Store;
SELECT * FROM Products;
SELECT * FROM Manager;
SELECT * FROM Floor_Staff;
SELECT * FROM Floor_Log;
SELECT * FROM Cashier;
SELECT * FROM Supervises;
SELECT * FROM Places_Order;
SELECT * FROM Make_Payment;
SELECT * FROM Ordered_Product;
SELECT * FROM Mall_Manager;
SELECT * FROM Popular_Product;
SELECT * FROM Gold_Store;
SELECT * FROM Top_Quarter_Cashier;

