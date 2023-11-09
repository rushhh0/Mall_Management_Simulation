CREATE VIEW Popular_Product AS
    SELECT 
        P.StoreID,
        P.ProductID,
        P.Name,
        P.Description,
        P.Price,
        SUM(OP.Quantity) AS Total_Sales
    FROM
        Products P
            JOIN
        Ordered_Product OP ON P.ProductId = OP.ProductId
            JOIN
        Places_order PO ON OP.orderId = PO.orderId
    WHERE
        P.ProductID = OP.ProductID
            AND PO.OrderID = OP.OrderID
            AND P.StoreID = PO.StoreID
            AND PO.Created_Time >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
    GROUP BY P.ProductID , P.StoreID
    ORDER BY Total_Sales DESC
    LIMIT 1;
    
    
CREATE VIEW Gold_Store AS
    SELECT 
        S.StoreID,
        S.Store_Type,
        S.Store_Location,
        COUNT(DISTINCT CustomerID) AS Total_Customers
    FROM
        Places_Order PO
            JOIN
        Store S ON PO.StoreID = S.StoreID
    WHERE
        PO.Created_Time >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
    GROUP BY StoreID
    ORDER BY Total_Customers DESC
    LIMIT 1;


CREATE VIEW Top_Quarter_Cashier (Cashier_ID , Cashier_Name) AS
    SELECT 
        C.EmployeeID, P.Name
    FROM
        Person P,
        Cashier C
            JOIN
        Make_Payment MP ON C.EmployeeID = MP.CashierID
            JOIN
        Places_Order PO ON MP.CustomerID = PO.CustomerID
    WHERE
        PO.Created_Time >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
    GROUP BY C.EmployeeID , P.Name
    ORDER BY COUNT(DISTINCT PO.OrderID) DESC
    LIMIT 1;