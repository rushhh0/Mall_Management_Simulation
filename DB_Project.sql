use DB_Project;

create table Person (
	PersonID	INT	AUTO_INCREMENT NOT NULL,
	Name	VARCHAR(20) NOT NULL,
	Gender	CHAR(1),
    DateOfBirth	DATE NOT NULL,
    Address	TEXT NOT NULL,
    PRIMARY KEY (PersonID)
);

create table Person_Phone_Numbers (
	PersonID	INT NOT NULL,
    Phone_Number	CHAR(10),
    
    FOREIGN KEY (PersonID) REFERENCES PERSON(PersonID) 
);

create table Employee (
	EmployeeID	INT NOT NULL,
    Salary INT,
    Start_Date DATE,
    
    FOREIGN KEY (EmployeeID) REFERENCES PERSON(PersonID) 
		ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (EmployeeID)
);

create table Customer (
	CustomerID INT NOT NULL,
    
    FOREIGN KEY (CustomerID) REFERENCES PERSON(PersonID),
    PRIMARY KEY (CustomerID)
);

create table Store (
	StoreID INT	AUTO_INCREMENT NOT NULL,
    Store_Type VARCHAR(20),
    Store_Location INT,
    Open_Time	TIME,
    Close_time	TIME,
    PRIMARY KEY (StoreID)
);


create table Products (
	ProductID	INT NOT NULL,
    Name VARCHAR(20) NOT NULL,
    Description TEXT,
    Price	DOUBLE(5, 2),
    StoreID	INT NOT NULL,
    Quantity	INT,
    
    FOREIGN KEY (StoreID) REFERENCES Store(StoreID)
		ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (StoreID, ProductID)
);

create table Manager (
	EmployeeID	INT NOT NULL,
    
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
		ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (EmployeeID)
);

create table Floor_Staff (
	EmployeeID	INT NOT NULL,
    ManagerID	INT NOT NULL,
    
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
		ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ManagerID) REFERENCES Manager(EmployeeID)
		ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (EmployeeID)
);

create table Floor_Log(
	Floor INT,
    FloorStaffID INT NOT NULL,
    Work_Date	DATE NOT NULL,
    
    FOREIGN KEY (FloorStaffID) REFERENCES Floor_Staff(EmployeeID)
		ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY(FloorStaffID, Work_Date)
);

create table Cashier (
	EmployeeID	INT NOT NULL,
    
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
		ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (EmployeeID)
);

create table Supervises (
	FloorStaffID INT NOT NULL,
    CashierID INT NOT NULL,
    
    FOREIGN KEY (FloorStaffID) REFERENCES Floor_Staff(EmployeeID)
		ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (CashierID) REFERENCES Cashier(EmployeeID)
		ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (FloorStaffID, CashierID)
);

create table Places_Order (
	OrderID	INT	AUTO_INCREMENT NOT NULL,
    Created_Time TIME,
    Subtotal	DOUBLE(5, 2),
    CustomerID INT NOT NULL,
    StoreID INT NOT NULL,
    
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (StoreID) REFERENCES Store(StoreID),
    PRIMARY KEY (OrderID)
);

create table Make_Payment (
    PaymentID INT AUTO_INCREMENT NOT NULL,
    Amount DOUBLE(5, 2) NOT NULL,
    Payment_Time TIME NOT NULL,
    Method TEXT NOT NULL,
    Other_Information TEXT,
    CustomerID INT NOT NULL,
    CashierID INT NOT NULL,
    
    PRIMARY KEY (PaymentID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE CASCADE,
    FOREIGN KEY (CashierID) REFERENCES Cashier(EmployeeID),
    CONSTRAINT CHK_PAYMENT_METHOD CHECK (Method IN ('Cash', 'Credit Card', 'Debit Card', 'PayPal'))
);


create table Ordered_Product (
    OrderID INT AUTO_INCREMENT NOT NULL,
    ProductID INT NOT NULL,
    Price DOUBLE(5, 2) NOT NULL,
    Quantity INT NOT NULL,
    
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Places_Order(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


create table Mall_Manager (
	ManagerID INT NOT NULL,
    
    FOREIGN KEY (ManagerID) REFERENCES Manager(EmployeeID),
    PRIMARY KEY (ManagerID)
);


