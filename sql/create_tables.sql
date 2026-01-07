CREATE DATABASE Retail
USE Retail
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS Shipping;
DROP TABLE IF EXISTS Customer_Address;
DROP TABLE IF EXISTS Individual_Order;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Supplier;
DROP TABLE IF EXISTS Warehouse;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS Store;



CREATE TABLE Customer (
   CustomerID INT IDENTITY(1,1) PRIMARY KEY,
   Email VARCHAR(255) UNIQUE NOT NULL,
   FirstName VARCHAR(100) NOT NULL,
   LastName VARCHAR(100) NOT NULL,
   PhoneNumber VARCHAR(20) NOT NULL CHECK (LEN(PhoneNumber) >= 10)
);


CREATE TABLE Supplier (
   SupplierID INT IDENTITY(1,1) PRIMARY KEY,
   SupplierName VARCHAR(255) NOT NULL,
   ContactInfo VARCHAR(255) NOT NULL
);


CREATE TABLE Warehouse (
   WarehouseID INT IDENTITY(1,1) PRIMARY KEY,
   Capacity INT CHECK (Capacity > 0),
   Location VARCHAR(255) NOT NULL
);


CREATE TABLE Product (
   ProductID INT IDENTITY(1,1) PRIMARY KEY,
   SupplierID INT,
   WarehouseID INT,
   ProductName VARCHAR(255) NOT NULL,
   Description VARCHAR(MAX),
   Price DECIMAL(10,2) CHECK (Price >= 0),
   Category VARCHAR(100),
   StockQuantity INT CHECK (StockQuantity >= 0),
   Rating DECIMAL(2,1) CHECK (Rating BETWEEN 0 AND 5),
   FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID),
   FOREIGN KEY (WarehouseID) REFERENCES Warehouse(WarehouseID)
);

CREATE TABLE Individual_Order (
   OrderID INT IDENTITY(1,1) PRIMARY KEY,
   CustomerID INT,
   ProductID INT,
   OrderDate DATE NOT NULL,
   TotalAmount DECIMAL(10,2) CHECK (TotalAmount >= 0),
   Quantity INT CHECK (Quantity > 0),
   Price DECIMAL(10,2) CHECK (Price >= 0),
   FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
   FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);


CREATE TABLE Payment (
   PaymentID INT IDENTITY(1,1) PRIMARY KEY,
   OrderID INT,
   PaymentMethod VARCHAR(50) NOT NULL,
   PaymentDate DATE NOT NULL,
   PaymentStatus VARCHAR(50) CHECK (PaymentStatus IN ('Pending', 'Completed', 'Failed')),
   TotalAmount DECIMAL(10,2) CHECK (TotalAmount >= 0),
   FOREIGN KEY (OrderID) REFERENCES Individual_Order(OrderID)
);


CREATE TABLE Customer_Address (
   AddressID INT IDENTITY(1,1) PRIMARY KEY,
   CustomerID INT,
   Street VARCHAR(255) NOT NULL,
   City VARCHAR(100) NOT NULL,
   State VARCHAR(100) NOT NULL,
   ZipCode VARCHAR(10) NOT NULL,
   AddressType VARCHAR(50) CHECK (AddressType IN ('Home', 'Work')),
   FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);


CREATE TABLE Shipping (
   ShippingID INT IDENTITY(1,1) PRIMARY KEY,
   OrderID INT,
   AddressID INT,
   ShippingMethod VARCHAR(50) NOT NULL,
   EstimatedDeliveryDate DATE NOT NULL,
   ShippingStatus VARCHAR(50) CHECK (ShippingStatus IN ('Pending', 'Shipped', 'Delivered', 'Cancelled')),
   FOREIGN KEY (OrderID) REFERENCES Individual_Order(OrderID),
   FOREIGN KEY (AddressID) REFERENCES Customer_Address(AddressID)
);


CREATE TABLE Store (
   StoreID INT IDENTITY(1,1) PRIMARY KEY,
   ManagerID INT,
   Location VARCHAR(255) NOT NULL
);


CREATE TABLE Department (
   DepartmentID INT IDENTITY(1,1) PRIMARY KEY,
   ManagerID INT,
   DepartmentName VARCHAR(255) NOT NULL,
   Location VARCHAR(255) NOT NULL
);


CREATE TABLE Employee (
   EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
   WarehouseID INT,
   DepartmentID INT,
   StoreID INT,
   FirstName VARCHAR(100) NOT NULL,
   LastName VARCHAR(100) NOT NULL,
   Role VARCHAR(100) NOT NULL,
   PhoneNumber VARCHAR(20) NOT NULL,
   HireDate DATE NOT NULL,
   FOREIGN KEY (WarehouseID) REFERENCES Warehouse(WarehouseID),
   FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
   FOREIGN KEY (StoreID) REFERENCES Store(StoreID)
);
