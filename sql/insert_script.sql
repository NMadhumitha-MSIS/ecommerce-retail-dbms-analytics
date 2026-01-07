-- Insert into Customer (20 records)
INSERT INTO Customer (Email, FirstName, LastName, PhoneNumber) VALUES
('alice@example.com', 'Alice', 'Johnson', '1234567890'),
('bob@example.com', 'Bob', 'Smith', '0987654321'),
('charlie@example.com', 'Charlie', 'Brown', '1112223333'),
('david@example.com', 'David', 'Williams', '2223334444'),
('eva@example.com', 'Eva', 'Miller', '3334445555'),
('frank@example.com', 'Frank', 'Davis', '4445556666'),
('grace@example.com', 'Grace', 'Wilson', '5556667777'),
('henry@example.com', 'Henry', 'Moore', '6667778888'),
('isabella@example.com', 'Isabella', 'Taylor', '7778889999'),
('jack@example.com', 'Jack', 'Anderson', '8889990000'),
('karen@example.com', 'Karen', 'Thomas', '1231231234'),
('larry@example.com', 'Larry', 'Jackson', '2342342345'),
('mary@example.com', 'Mary', 'White', '3453453456'),
('noah@example.com', 'Noah', 'Harris', '4564564567'),
('olivia@example.com', 'Olivia', 'Martin', '5675675678'),
('paul@example.com', 'Paul', 'Thompson', '6786786789'),
('quinn@example.com', 'Quinn', 'Garcia', '7897897890'),
('rachel@example.com', 'Rachel', 'Martinez', '8908908901'),
('sam@example.com', 'Sam', 'Robinson', '9019019012'),
('tyler@example.com', 'Tyler', 'Clark', '0120120123');

-- Insert into Supplier (20 records)
INSERT INTO Supplier (SupplierName, ContactInfo) VALUES
('Tech Supplier', 'tech@example.com'),
('Gadget Corp', 'gadget@example.com'),
('Home Essentials', 'home@example.com'),
('Furniture World', 'furniture@example.com'),
('Auto Parts Inc.', 'auto@example.com'),
('Fashion Trends', 'fashion@example.com'),
('Sports Gear Ltd.', 'sports@example.com'),
('Health & Beauty', 'beauty@example.com'),
('Toy Kingdom', 'toys@example.com'),
('Food Supply Co.', 'food@example.com'),
('Electronic Hub', 'ehub@example.com'),
('Kitchen Maestro', 'kitchen@example.com'),
('Office Solutions', 'office@example.com'),
('Outdoor Living', 'outdoor@example.com'),
('Pet Supplies Plus', 'pets@example.com'),
('Book Publishers Inc', 'books@example.com'),
('Music & Audio', 'music@example.com'),
('Garden Center', 'garden@example.com'),
('Baby Products', 'baby@example.com'),
('Art Supplies Co.', 'art@example.com');

-- Insert into Warehouse (20 records)
INSERT INTO Warehouse (Capacity, Location) VALUES
(500, 'New York'),
(700, 'Los Angeles'),
(600, 'Chicago'),
(800, 'Houston'),
(1000, 'San Francisco'),
(750, 'Miami'),
(900, 'Seattle'),
(850, 'Denver'),
(650, 'Boston'),
(550, 'Atlanta'),
(825, 'Phoenix'),
(975, 'Philadelphia'),
(525, 'San Diego'),
(625, 'Dallas'),
(775, 'Austin'),
(875, 'Portland'),
(925, 'Nashville'),
(575, 'New Orleans'),
(725, 'Minneapolis'),
(675, 'Detroit');

-- Insert into Product (40 records with diverse categories)
INSERT INTO Product (SupplierID, WarehouseID, ProductName, Description, Price, Category, StockQuantity, Rating) VALUES
-- Electronics
(1, 1, 'Premium Laptop', 'High-end gaming laptop', 1499.99, 'Electronics', 50, 4.7),
(2, 2, 'Smartphone Pro', 'Latest model smartphone', 999.99, 'Electronics', 100, 4.5),
(11, 3, 'Wireless Earbuds', 'Noise cancelling earbuds', 149.99, 'Electronics', 200, 4.3),
(1, 4, 'Smart TV 55"', '4K Ultra HD Smart TV', 699.99, 'Electronics', 30, 4.6),
(11, 5, 'Digital Camera', 'Professional DSLR camera', 899.99, 'Electronics', 25, 4.8),
(2, 6, 'Smart Watch', 'Fitness and health tracker', 249.99, 'Electronics', 75, 4.4),
(1, 7, 'Bluetooth Speaker', 'Waterproof portable speaker', 89.99, 'Electronics', 120, 4.2),
(11, 8, 'Tablet Pro', '10-inch tablet with stylus', 449.99, 'Electronics', 50, 4.5),

-- Home Appliances
(3, 9, 'Blender Pro', 'High-speed kitchen blender', 129.99, 'Home Appliances', 40, 4.3),
(12, 10, 'Coffee Maker', 'Programmable coffee machine', 79.99, 'Home Appliances', 60, 4.1),
(3, 11, 'Robot Vacuum', 'Smart robot vacuum cleaner', 299.99, 'Home Appliances', 35, 4.7),
(12, 12, 'Toaster Oven', 'Convection toaster oven', 119.99, 'Home Appliances', 45, 4.0),

-- Furniture
(4, 13, 'Leather Sofa', 'Luxury leather sofa', 1299.99, 'Furniture', 15, 4.8),
(4, 14, 'Dining Table Set', 'Wooden dining table with 6 chairs', 799.99, 'Furniture', 20, 4.6),
(4, 15, 'Bookshelf', 'Modern 5-tier bookshelf', 189.99, 'Furniture', 30, 4.3),
(14, 16, 'Office Desk', 'Ergonomic office desk', 249.99, 'Furniture', 25, 4.5),

-- Automotive
(5, 17, 'Car Tires Set', 'All-season tire set of 4', 399.99, 'Automotive', 30, 4.4),
(5, 18, 'Car Battery', 'High-performance car battery', 129.99, 'Automotive', 40, 4.2),
(5, 19, 'Dash Cam', 'HD dashboard camera', 89.99, 'Automotive', 50, 4.1),
(5, 20, 'Car Cover', 'All-weather car cover', 59.99, 'Automotive', 60, 4.0),

-- Fashion
(6, 1, 'Designer Jeans', 'Premium denim jeans', 89.99, 'Fashion', 100, 4.5),
(6, 2, 'Winter Jacket', 'Insulated winter coat', 129.99, 'Fashion', 80, 4.6),
(6, 3, 'Running Shoes', 'Performance running footwear', 119.99, 'Fashion', 90, 4.7),
(6, 4, 'Leather Handbag', 'Luxury leather handbag', 199.99, 'Fashion', 70, 4.8),

-- Sports
(7, 5, 'Basketball', 'Official size basketball', 39.99, 'Sports', 120, 4.6),
(7, 6, 'Tennis Racket', 'Professional tennis racket', 149.99, 'Sports', 60, 4.5),
(7, 7, 'Yoga Mat', 'Premium non-slip yoga mat', 29.99, 'Sports', 150, 4.4),
(7, 8, 'Dumbbell Set', '5-25 lb adjustable dumbbells', 199.99, 'Sports', 40, 4.7),

-- Beauty & Health
(8, 9, 'Premium Shampoo', 'Organic herbal shampoo', 24.99, 'Beauty & Health', 200, 4.5),
(8, 10, 'Facial Cream', 'Anti-aging facial moisturizer', 39.99, 'Beauty & Health', 180, 4.6),
(8, 11, 'Electric Toothbrush', 'Sonic electric toothbrush', 69.99, 'Beauty & Health', 90, 4.7),
(8, 12, 'Hair Dryer', 'Professional salon hair dryer', 79.99, 'Beauty & Health', 70, 4.4),

-- Toys
(9, 13, 'LEGO Building Set', 'Advanced LEGO set', 89.99, 'Toys', 60, 4.8),
(9, 14, 'Remote Control Car', 'High-speed RC car', 59.99, 'Toys', 70, 4.5),
(9, 15, 'Plush Bear', 'Soft teddy bear', 19.99, 'Toys', 100, 4.4),
(9, 16, 'Board Game', 'Strategy board game', 34.99, 'Toys', 80, 4.6),

-- Food
(10, 17, 'Gourmet Olive Oil', 'Premium extra virgin olive oil', 29.99, 'Food', 150, 4.9),
(10, 18, 'Chocolate Box', 'Assorted gourmet chocolates', 24.99, 'Food', 200, 4.8),
(10, 19, 'Spice Collection', 'Gourmet spice gift set', 39.99, 'Food', 120, 4.7),
(10, 20, 'Organic Tea Set', 'Assorted organic teas', 19.99, 'Food', 180, 4.6);

-- Insert into Customer_Address (20 records)
INSERT INTO Customer_Address (CustomerID, Street, City, State, ZipCode, AddressType) VALUES
(1, '123 Main St', 'New York', 'NY', '10001', 'Home'),
(2, '456 Elm St', 'Los Angeles', 'CA', '90001', 'Work'),
(3, '789 Maple Ave', 'Chicago', 'IL', '60601', 'Home'),
(4, '321 Oak St', 'Houston', 'TX', '77001', 'Work'),
(5, '654 Pine St', 'San Francisco', 'CA', '94101', 'Home'),
(6, '987 Cedar Ave', 'Miami', 'FL', '33101', 'Work'),
(7, '159 Birch St', 'Seattle', 'WA', '98101', 'Home'),
(8, '753 Willow St', 'Denver', 'CO', '80201', 'Work'),
(9, '852 Aspen Ave', 'Boston', 'MA', '02101', 'Home'),
(10, '951 Redwood St', 'Atlanta', 'GA', '30301', 'Work'),
(11, '147 Park Ave', 'Phoenix', 'AZ', '85001', 'Home'),
(12, '258 Lake St', 'Philadelphia', 'PA', '19101', 'Work'),
(13, '369 River Rd', 'San Diego', 'CA', '92101', 'Home'),
(14, '470 Mountain View', 'Dallas', 'TX', '75201', 'Work'),
(15, '581 Valley Way', 'Austin', 'TX', '78701', 'Home'),
(16, '692 Ocean Blvd', 'Portland', 'OR', '97201', 'Work'),
(17, '803 Forest Path', 'Nashville', 'TN', '37201', 'Home'),
(18, '914 Bayou St', 'New Orleans', 'LA', '70112', 'Work'),
(19, '125 Summit Ave', 'Minneapolis', 'MN', '55401', 'Home'),
(20, '236 Industrial Dr', 'Detroit', 'MI', '48201', 'Work');

-- Insert into Store (20 records)
INSERT INTO Store (ManagerID, Location) VALUES
(1, 'Downtown New York'),
(2, 'Uptown Los Angeles'),
(3, 'Chicago North Side'),
(4, 'Houston Mall'),
(5, 'San Francisco Bay'),
(6, 'Miami Beach'),
(7, 'Seattle Center'),
(8, 'Denver Tech Park'),
(9, 'Boston Harbor'),
(10, 'Atlanta Midtown'),
(11, 'Phoenix Desert View'),
(12, 'Philadelphia Historic'),
(13, 'San Diego Waterfront'),
(14, 'Dallas Uptown'),
(15, 'Austin Music District'),
(16, 'Portland Eco Center'),
(17, 'Nashville Music Row'),
(18, 'New Orleans French Quarter'),
(19, 'Minneapolis Riverside'),
(20, 'Detroit Renaissance');

-- Insert into Department (20 records)
INSERT INTO Department (ManagerID, DepartmentName, Location) VALUES
(1, 'Human Resources', 'Head Office'),
(2, 'Finance', 'Downtown Office'),
(3, 'Information Technology', 'Tech Hub'),
(4, 'Operations', 'Warehouse Complex'),
(5, 'Marketing', 'Creative Center'),
(6, 'Customer Service', 'Support Center'),
(7, 'Logistics', 'Distribution Center'),
(8, 'Sales', 'Main Office'),
(9, 'Legal', 'Corporate Office'),
(10, 'Security', 'Operations Center'),
(11, 'Research & Development', 'Innovation Lab'),
(12, 'Public Relations', 'Media Center'),
(13, 'Quality Control', 'Testing Facility'),
(14, 'Procurement', 'Supply Center'),
(15, 'Training', 'Learning Center'),
(16, 'Facilities Management', 'Main Campus'),
(17, 'International Relations', 'Global Office'),
(18, 'Product Development', 'Design Studio'),
(19, 'Sustainability', 'Green Building'),
(20, 'E-commerce', 'Digital Hub');

-- Insert into Employee (20 records)
INSERT INTO Employee (WarehouseID, DepartmentID, StoreID, FirstName, LastName, Role, PhoneNumber, HireDate) VALUES
(1, 1, 1, 'John', 'Doe', 'HR Manager', '1234567890', '2020-01-15'),
(2, 2, 2, 'Jane', 'Smith', 'Finance Director', '0987654321', '2020-03-22'),
(3, 3, 3, 'Michael', 'Johnson', 'IT Specialist', '1112223333', '2020-05-10'),
(4, 4, 4, 'Emily', 'Williams', 'Operations Manager', '4445556666', '2020-07-05'),
(5, 5, 5, 'Robert', 'Brown', 'Marketing Director', '7778889999', '2020-09-18'),
(6, 6, 6, 'Susan', 'Jones', 'Customer Service Rep', '0001112222', '2020-11-30'),
(7, 7, 7, 'David', 'Miller', 'Logistics Coordinator', '3334445555', '2021-01-12'),
(8, 8, 8, 'Sarah', 'Davis', 'Sales Manager', '6667778888', '2021-03-25'),
(9, 9, 9, 'Thomas', 'Wilson', 'Legal Counsel', '9990001111', '2021-05-07'),
(10, 10, 10, 'Jessica', 'Taylor', 'Security Officer', '2223334444', '2021-07-19'),
(11, 11, 11, 'Kevin', 'Anderson', 'R&D Scientist', '5556667777', '2021-09-03'),
(12, 12, 12, 'Laura', 'Thomas', 'PR Specialist', '8889990000', '2021-11-15'),
(13, 13, 13, 'Brian', 'Jackson', 'QA Engineer', '1231231234', '2022-01-27'),
(14, 14, 14, 'Michelle', 'White', 'Procurement Analyst', '2342342345', '2022-03-10'),
(15, 15, 15, 'Christopher', 'Harris', 'Training Coordinator', '3453453456', '2022-05-22'),
(16, 16, 16, 'Amanda', 'Martin', 'Facilities Manager', '4564564567', '2022-07-04'),
(17, 17, 17, 'Daniel', 'Thompson', 'International Liaison', '5675675678', '2022-09-16'),
(18, 18, 18, 'Jennifer', 'Garcia', 'Product Designer', '6786786789', '2022-11-28'),
(19, 19, 19, 'Matthew', 'Martinez', 'Sustainability Officer', '7897897890', '2023-01-09'),
(20, 20, 20, 'Elizabeth', 'Robinson', 'E-commerce Specialist', '8908908901', '2023-03-21');

-- Insert into Individual_Order (100 records spanning multiple years, each customer orders 5 different products)
INSERT INTO Individual_Order (CustomerID, ProductID, OrderDate, TotalAmount, Quantity, Price) VALUES
-- Customer 1
(1, 1, '2020-03-15', 2999.98, 2, 1499.99),    -- Electronics (2020)
(1, 13, '2021-04-22', 5199.96, 4, 1299.99),   -- Furniture (2021)
(1, 25, '2022-06-10', 199.95, 5, 39.99),      -- Sports (2022)
(1, 33, '2023-08-05', 359.96, 4, 89.99),      -- Toys (2023)
(1, 37, '2024-01-30', 89.97, 3, 29.99),       -- Food (2024)

-- Customer 2
(2, 2, '2020-05-20', 2999.97, 3, 999.99),     -- Electronics (2020)
(2, 14, '2021-07-15', 3999.95, 5, 799.99),    -- Furniture (2021)
(2, 26, '2022-09-18', 449.97, 3, 149.99),     -- Sports (2022)
(2, 34, '2023-11-22', 239.96, 4, 59.99),      -- Toys (2023)
(2, 38, '2024-02-10', 74.97, 3, 24.99),       -- Food (2024)

-- Customer 3
(3, 3, '2020-02-10', 599.96, 4, 149.99),      -- Electronics (2020)
(3, 9, '2021-05-15', 259.98, 2, 129.99),      -- Home Appliances (2021)
(3, 21, '2022-08-22', 629.93, 7, 89.99),      -- Fashion (2022)
(3, 29, '2023-10-08', 199.95, 5, 39.99),      -- Beauty & Health (2023)
(3, 39, '2024-01-05', 319.92, 8, 39.99),      -- Food (2024)

-- Customer 4
(4, 4, '2020-06-30', 2099.97, 3, 699.99),     -- Electronics (2020)
(4, 10, '2021-08-12', 639.92, 8, 79.99),      -- Home Appliances (2021)
(4, 22, '2022-04-25', 389.97, 3, 129.99),     -- Fashion (2022)
(4, 30, '2023-03-18', 279.93, 7, 39.99),      -- Beauty & Health (2023)
(4, 40, '2024-02-27', 179.91, 9, 19.99),      -- Food (2024)

-- Customer 5
(5, 5, '2020-09-05', 6299.93, 7, 899.99),     -- Electronics (2020)
(5, 11, '2021-11-10', 899.97, 3, 299.99),     -- Home Appliances (2021)
(5, 17, '2022-01-15', 1999.95, 5, 399.99),    -- Automotive (2022)
(5, 27, '2023-04-20', 239.92, 8, 29.99),      -- Sports (2023)
(5, 37, '2024-03-25', 89.97, 3, 29.99),       -- Food (2024)

-- Customer 6
(6, 6, '2020-01-12', 1249.95, 5, 249.99),     -- Electronics (2020)
(6, 12, '2021-03-08', 479.96, 4, 119.99),     -- Home Appliances (2021)
(6, 18, '2022-05-19', 1039.92, 8, 129.99),    -- Automotive (2022)
(6, 28, '2023-07-27', 599.97, 3, 199.99),     -- Sports (2023)
(6, 38, '2024-02-14', 224.91, 9, 24.99),      -- Food (2024)

-- Customer 7
(7, 7, '2020-04-03', 719.92, 8, 89.99),       -- Electronics (2020)
(7, 13, '2021-06-22', 6499.95, 5, 1299.99),   -- Furniture (2021)
(7, 19, '2022-09-11', 179.98, 2, 89.99),      -- Automotive (2022)
(7, 31, '2023-12-05', 559.92, 8, 69.99),      -- Beauty & Health (2023)
(7, 39, '2024-03-01', 319.92, 8, 39.99),      -- Food (2024)

-- Customer 8
(8, 8, '2020-07-17', 1349.97, 3, 449.99),     -- Electronics (2020)
(8, 14, '2021-09-28', 3999.95, 5, 799.99),    -- Furniture (2021)
(8, 20, '2022-12-15', 539.91, 9, 59.99),      -- Automotive (2022)
(8, 32, '2023-01-30', 639.92, 8, 79.99),      -- Beauty & Health (2023)
(8, 40, '2024-03-14', 179.91, 9, 19.99),      -- Food (2024)

-- Customer 9
(9, 1, '2020-10-10', 4499.97, 3, 1499.99),    -- Electronics (2020)
(9, 15, '2021-12-25', 1519.92, 8, 189.99),    -- Furniture (2021)
(9, 21, '2022-02-14', 719.92, 8, 89.99),      -- Fashion (2022)
(9, 33, '2023-05-05', 269.97, 3, 89.99),      -- Toys (2023)
(9, 37, '2024-03-20', 269.91, 9, 29.99),      -- Food (2024)

-- Customer 10
(10, 2, '2020-03-21', 1999.98, 2, 999.99),    -- Electronics (2020)
(10, 16, '2021-05-17', 1249.95, 5, 249.99),   -- Furniture (2021)
(10, 22, '2022-07-09', 1039.92, 8, 129.99),   -- Fashion (2022)
(10, 34, '2023-10-31', 479.92, 8, 59.99),     -- Toys (2023)
(10, 38, '2024-01-15', 224.91, 9, 24.99),     -- Food (2024)

-- Customer 11
(11, 3, '2020-02-28', 149.99 * 3, 3, 149.99),     -- Electronics (2020)
(11, 9, '2021-04-15', 129.99 * 2, 2, 129.99),     -- Home Appliances (2021)
(11, 23, '2022-06-22', 119.99 * 4, 4, 119.99),    -- Fashion (2022)
(11, 35, '2023-09-09', 19.99 * 2, 2, 19.99),      -- Toys (2023)
(11, 39, '2024-02-02', 39.99 * 4, 4, 39.99),      -- Food (2024)


-- Customer 12
(12, 4, '2020-05-05', 699.99 * 3, 3, 699.99),     -- Electronics (2020)
(12, 10, '2021-08-18', 79.99 * 5, 5, 79.99),      -- Home Appliances (2021)
(12, 24, '2022-11-11', 199.99 * 2, 2, 199.99),    -- Fashion (2022)
(12, 36, '2023-01-20', 34.99 * 7, 7, 34.99),      -- Toys (2023)
(12, 40, '2024-03-10', 19.99 * 4, 4, 19.99),      -- Food (2024)

-- Customer 13
(13, 5, '2020-08-29', 899.99 * 1, 1, 899.99),     -- Electronics (2020)
(13, 11, '2021-10-13', 299.99 * 2, 2, 299.99),    -- Home Appliances (2021)
(13, 17, '2022-01-07', 399.99 * 4, 4, 399.99),    -- Automotive (2022)
(13, 29, '2023-03-28', 39.99 * 8, 8, 39.99),      -- Beauty & Health (2023)
(13, 37, '2024-02-18', 29.99 * 6, 6, 29.99),      -- Food (2024)

-- Customer 14
(14, 6, '2020-11-15', 249.99 * 2, 2, 249.99),     -- Electronics (2020)
(14, 12, '2021-01-30', 119.99 * 3, 3, 119.99),    -- Home Appliances (2021)
(14, 18, '2022-03-15', 129.99 * 1, 1, 129.99),    -- Automotive (2022)
(14, 30, '2023-06-22', 39.99 * 9, 9, 39.99),      -- Beauty & Health (2023)
(14, 38, '2024-01-05', 24.99 * 5, 5, 24.99),      -- Food (2024)

-- Customer 15
(15, 7, '2020-01-05', 89.99 * 4, 4, 89.99),       -- Electronics (2020)
(15, 13, '2021-02-20', 1299.99 * 1, 1, 1299.99),  -- Furniture (2021)
(15, 19, '2022-04-08', 89.99 * 2, 2, 89.99),      -- Automotive (2022)
(15, 31, '2023-07-15', 69.99 * 3, 3, 69.99),      -- Beauty & Health (2023)
(15, 39, '2024-02-28', 39.99 * 7, 7, 39.99),      -- Food (2024)

-- Customer 16
(16, 8, '2020-04-19', 449.99 * 1, 1, 449.99),     -- Electronics (2020)
(16, 14, '2021-07-02', 799.99 * 1, 1, 799.99),    -- Furniture (2021)
(16, 20, '2022-10-25', 59.99 * 6, 6, 59.99),      -- Automotive (2022)
(16, 32, '2023-12-18', 79.99 * 4, 4, 79.99),      -- Beauty & Health (2023)
(16, 40, '2024-03-05', 19.99 * 9, 9, 19.99),      -- Food (2024)

-- Customer 17
(17, 1, '2020-06-11', 1499.99 * 1, 1, 1499.99),   -- Electronics (2020)
(17, 15, '2021-09-05', 189.99 * 3, 3, 189.99),    -- Furniture (2021)
(17, 25, '2022-12-20', 39.99 * 8, 8, 39.99),      -- Sports (2022)
(17, 33, '2023-02-14', 89.99 * 2, 2, 89.99),      -- Toys (2023)
(17, 37, '2024-01-25', 29.99 * 5, 5, 29.99),      -- Food (2024)

-- Customer 18
(18, 2, '2020-09-22', 999.99 * 1, 1, 999.99),     -- Electronics (2020)
(18, 16, '2021-11-15', 249.99 * 2, 2, 249.99),    -- Furniture (2021)
(18, 26, '2022-01-30', 149.99 * 3, 3, 149.99),    -- Sports (2022)
(18, 34, '2023-04-25', 59.99 * 6, 6, 59.99),      -- Toys (2023)
(18, 38, '2024-03-15', 24.99 * 4, 4, 24.99),      -- Food (2024)

-- Customer 19
(19, 3, '2020-12-05', 149.99 * 2, 2, 149.99),     -- Electronics (2020)
(19, 9, '2021-02-10', 129.99 * 3, 3, 129.99),     -- Home Appliances (2021)
(19, 27, '2022-04-15', 29.99 * 9, 9, 29.99),      -- Sports (2022)
(19, 35, '2023-08-20', 19.99 * 7, 7, 19.99),      -- Toys (2023)
(19, 39, '2024-02-25', 39.99 * 2, 2, 39.99),      -- Food (2024)

-- Customer 20
(20, 4, '2020-10-30', 699.99 * 1, 1, 699.99),     -- Electronics (2020)
(20, 10, '2021-12-10', 79.99 * 6, 6, 79.99),      -- Home Appliances (2021)
(20, 28, '2022-03-05', 199.99 * 2, 2, 199.99),    -- Sports (2022)
(20, 36, '2023-06-15', 34.99 * 8, 8, 34.99),      -- Toys (2023)
(20, 40, '2024-01-10', 19.99 * 3, 3, 19.99);

INSERT INTO Payment (OrderID, PaymentMethod, PaymentDate, PaymentStatus, TotalAmount) VALUES
-- Customer 1
(1, 'Credit Card', '2020-03-15', 'Completed', 2999.98),
(2, 'PayPal', '2021-04-22', 'Completed', 5199.96),
(3, 'Credit Card', '2022-06-10', 'Completed', 199.95),
(4, 'Debit Card', '2023-08-05', 'Completed', 359.96),
(5, 'Mobile Payment', '2024-01-30', 'Completed', 89.97),

-- Customer 2
(6, 'Credit Card', '2020-05-20', 'Completed', 2999.97),
(7, 'Bank Transfer', '2021-07-15', 'Completed', 3999.95),
(8, 'Credit Card', '2022-09-18', 'Completed', 449.97),
(9, 'Mobile Payment', '2023-11-22', 'Completed', 239.96),
(10, 'PayPal', '2024-02-10', 'Completed', 74.97),

-- Customer 3
(11, 'Debit Card', '2020-02-10', 'Completed', 599.96),
(12, 'Credit Card', '2021-05-15', 'Completed', 259.98),
(13, 'Mobile Payment', '2022-08-22', 'Completed', 629.93),
(14, 'PayPal', '2023-10-08', 'Completed', 199.95),
(15, 'Credit Card', '2024-01-05', 'Completed', 319.92),

-- Customer 4
(16, 'Bank Transfer', '2020-06-30', 'Completed', 2099.97),
(17, 'Credit Card', '2021-08-12', 'Completed', 639.92),
(18, 'Mobile Payment', '2022-04-25', 'Completed', 389.97),
(19, 'PayPal', '2023-03-18', 'Completed', 279.93),
(20, 'Debit Card', '2024-02-27', 'Completed', 179.91),

-- Customer 5
(21, 'Credit Card', '2020-09-05', 'Completed', 6299.93),
(22, 'Mobile Payment', '2021-11-10', 'Completed', 899.97),
(23, 'Bank Transfer', '2022-01-15', 'Completed', 1999.95),
(24, 'Credit Card', '2023-04-20', 'Completed', 239.92),
(25, 'PayPal', '2024-03-25', 'Completed', 89.97),

-- Customer 6
(26, 'Debit Card', '2020-01-12', 'Completed', 1249.95),
(27, 'Credit Card', '2021-03-08', 'Completed', 479.96),
(28, 'PayPal', '2022-05-19', 'Completed', 1039.92),
(29, 'Mobile Payment', '2023-07-27', 'Completed', 599.97),
(30, 'Credit Card', '2024-02-14', 'Completed', 224.91),

-- Customer 7
(31, 'Bank Transfer', '2020-04-03', 'Completed', 719.92),
(32, 'Credit Card', '2021-06-22', 'Completed', 6499.95),
(33, 'Debit Card', '2022-09-11', 'Completed', 179.98),
(34, 'PayPal', '2023-12-05', 'Completed', 559.92),
(35, 'Mobile Payment', '2024-03-01', 'Completed', 319.92),

-- Customer 8
(36, 'Credit Card', '2020-07-17', 'Completed', 1349.97),
(37, 'Bank Transfer', '2021-09-28', 'Completed', 3999.95),
(38, 'Mobile Payment', '2022-12-15', 'Completed', 539.91),
(39, 'Credit Card', '2023-01-30', 'Completed', 639.92),
(40, 'PayPal', '2024-03-14', 'Completed', 179.91),

-- Customer 9
(41, 'Debit Card', '2020-10-10', 'Completed', 4499.97),
(42, 'Credit Card', '2021-12-25', 'Completed', 1519.92),
(43, 'Bank Transfer', '2022-02-14', 'Completed', 719.92),
(44, 'Mobile Payment', '2023-05-05', 'Completed', 269.97),
(45, 'PayPal', '2024-03-20', 'Completed', 269.91),

-- Customer 10
(46, 'Credit Card', '2020-03-21', 'Completed', 1999.98),
(47, 'Debit Card', '2021-05-17', 'Completed', 1249.95),
(48, 'Mobile Payment', '2022-07-09', 'Completed', 1039.92),
(49, 'Credit Card', '2023-10-31', 'Completed', 479.92),
(50, 'Bank Transfer', '2024-01-15', 'Completed', 224.91),

-- Customer 11
(51, 'PayPal', '2020-02-28', 'Completed', 449.97),
(52, 'Credit Card', '2021-04-15', 'Completed', 259.98),
(53, 'Mobile Payment', '2022-06-22', 'Completed', 479.96),
(54, 'Debit Card', '2023-09-09', 'Completed', 39.98),
(55, 'Credit Card', '2024-02-02', 'Completed', 159.96),

-- Customer 12
(56, 'Bank Transfer', '2020-05-05', 'Completed', 2099.97),
(57, 'Credit Card', '2021-08-18', 'Completed', 399.95),
(58, 'PayPal', '2022-11-11', 'Completed', 399.98),
(59, 'Mobile Payment', '2023-01-20', 'Completed', 244.93),
(60, 'Debit Card', '2024-03-10', 'Completed', 79.96),

-- Customer 13
(61, 'Credit Card', '2020-08-29', 'Completed', 899.99),
(62, 'Mobile Payment', '2021-10-13', 'Completed', 599.98),
(63, 'Bank Transfer', '2022-01-07', 'Completed', 1599.96),
(64, 'Credit Card', '2023-03-28', 'Completed', 319.92),
(65, 'PayPal', '2024-02-18', 'Completed', 179.94),

-- Customer 14
(66, 'Debit Card', '2020-11-15', 'Completed', 499.98),
(67, 'Credit Card', '2021-01-30', 'Completed', 359.97),
(68, 'Mobile Payment', '2022-03-15', 'Completed', 129.99),
(69, 'Bank Transfer', '2023-06-22', 'Completed', 359.91),
(70, 'PayPal', '2024-01-05', 'Completed', 124.95),

-- Customer 15
(71, 'Credit Card', '2020-01-05', 'Completed', 359.96),
(72, 'Debit Card', '2021-02-20', 'Completed', 1299.99),
(73, 'PayPal', '2022-04-08', 'Completed', 179.98),
(74, 'Mobile Payment', '2023-07-15', 'Completed', 209.97),
(75, 'Credit Card', '2024-02-28', 'Completed', 279.93),

-- Customer 16
(76, 'Bank Transfer', '2020-04-19', 'Completed', 449.99),
(77, 'Credit Card', '2021-07-02', 'Completed', 799.99),
(78, 'Mobile Payment', '2022-10-25', 'Completed', 359.94),
(79, 'PayPal', '2023-12-18', 'Completed', 319.96),
(80, 'Debit Card', '2024-03-05', 'Completed', 179.91),

-- Customer 17
(81, 'Credit Card', '2020-06-11', 'Completed', 1499.99),
(82, 'Bank Transfer', '2021-09-05', 'Completed', 569.97),
(83, 'PayPal', '2022-12-20', 'Completed', 319.92),
(84, 'Mobile Payment', '2023-02-14', 'Completed', 179.98),
(85, 'Credit Card', '2024-01-25', 'Completed', 149.95),

-- Customer 18
(86, 'Debit Card', '2020-09-22', 'Completed', 999.99),
(87, 'Credit Card', '2021-11-15', 'Completed', 499.98),
(88, 'Mobile Payment', '2022-01-30', 'Completed', 449.97),
(89, 'Bank Transfer', '2023-04-25', 'Completed', 359.94),
(90, 'PayPal', '2024-03-15', 'Completed', 99.96),

-- Customer 19
(91, 'Credit Card', '2020-12-05', 'Completed', 299.98),
(92, 'Mobile Payment', '2021-02-10', 'Completed', 389.97),
(93, 'PayPal', '2022-04-15', 'Completed', 269.91),
(94, 'Debit Card', '2023-08-20', 'Completed', 139.93),
(95, 'Bank Transfer', '2024-02-25', 'Completed', 79.98),

-- Customer 20
(96, 'Credit Card', '2020-10-30', 'Completed', 699.99),
(97, 'PayPal', '2021-12-10', 'Completed', 479.94),
(98, 'Mobile Payment', '2022-03-05', 'Completed', 399.98),
(99, 'Debit Card', '2023-06-15', 'Completed', 279.92),
(100, 'Credit Card', '2024-01-10', 'Completed', 59.97);

INSERT INTO Shipping (OrderID, AddressID, ShippingMethod, EstimatedDeliveryDate, ShippingStatus) VALUES
-- Customer 1 orders
(1, 1, 'FedEx', '2020-03-20', 'Delivered'),
(2, 1, 'UPS', '2021-04-26', 'Delivered'),
(3, 1, 'USPS', '2022-06-13', 'Delivered'),
(4, 1, 'DHL', '2023-08-09', 'Delivered'),
(5, 1, 'Local Delivery', '2024-02-01', 'Delivered'),

-- Customer 2 orders
(6, 2, 'UPS', '2020-05-24', 'Delivered'),
(7, 2, 'FedEx', '2021-07-20', 'Delivered'),
(8, 2, 'DHL', '2022-09-22', 'Delivered'),
(9, 2, 'USPS', '2023-11-25', 'Delivered'),
(10, 2, 'Local Delivery', '2024-02-12', 'Delivered'),

-- Customer 3 orders
(11, 3, 'DHL', '2020-02-14', 'Delivered'),
(12, 3, 'FedEx', '2021-05-20', 'Delivered'),
(13, 3, 'UPS', '2022-08-26', 'Delivered'),
(14, 3, 'Local Delivery', '2023-10-10', 'Delivered'),
(15, 3, 'USPS', '2024-01-08', 'Delivered'),

-- Customer 4 orders
(16, 4, 'FedEx', '2020-07-05', 'Delivered'),
(17, 4, 'UPS', '2021-08-16', 'Delivered'),
(18, 4, 'DHL', '2022-04-29', 'Delivered'),
(19, 4, 'USPS', '2023-03-21', 'Delivered'),
(20, 4, 'Local Delivery', '2024-02-29', 'Delivered'),

-- Customer 5 orders
(21, 5, 'UPS', '2020-09-09', 'Delivered'),
(22, 5, 'FedEx', '2021-11-15', 'Delivered'),
(23, 5, 'USPS', '2022-01-18', 'Delivered'),
(24, 5, 'DHL', '2023-04-24', 'Delivered'),
(25, 5, 'Local Delivery', '2024-03-27', 'Delivered'),

-- Customer 6 orders
(26, 6, 'DHL', '2020-01-16', 'Delivered'),
(27, 6, 'FedEx', '2021-03-13', 'Delivered'),
(28, 6, 'UPS', '2022-05-23', 'Delivered'),
(29, 6, 'Local Delivery', '2023-07-29', 'Delivered'),
(30, 6, 'USPS', '2024-02-17', 'Delivered'),

-- Customer 7 orders
(31, 7, 'FedEx', '2020-04-08', 'Delivered'),
(32, 7, 'UPS', '2021-06-26', 'Delivered'),
(33, 7, 'DHL', '2022-09-15', 'Delivered'),
(34, 7, 'USPS', '2023-12-08', 'Delivered'),
(35, 7, 'Local Delivery', '2024-03-03', 'Delivered'),

-- Customer 8 orders
(36, 8, 'UPS', '2020-07-21', 'Delivered'),
(37, 8, 'FedEx', '2021-10-03', 'Delivered'),
(38, 8, 'USPS', '2022-12-18', 'Delivered'),
(39, 8, 'DHL', '2023-02-03', 'Delivered'),
(40, 8, 'Local Delivery', '2024-03-16', 'Delivered'),

-- Customer 9 orders
(41, 9, 'DHL', '2020-10-14', 'Delivered'),
(42, 9, 'FedEx', '2021-12-30', 'Delivered'),
(43, 9, 'UPS', '2022-02-18', 'Delivered'),
(44, 9, 'Local Delivery', '2023-05-07', 'Delivered'),
(45, 9, 'USPS', '2024-03-23', 'Delivered'),

-- Customer 10 orders
(46, 10, 'FedEx', '2020-03-26', 'Delivered'),
(47, 10, 'UPS', '2021-05-21', 'Delivered'),
(48, 10, 'DHL', '2022-07-13', 'Delivered'),
(49, 10, 'USPS', '2023-11-03', 'Delivered'),
(50, 10, 'Local Delivery', '2024-01-17', 'Delivered'),

-- Customer 11 orders
(51, 11, 'UPS', '2020-03-03', 'Delivered'),
(52, 11, 'FedEx', '2021-04-20', 'Delivered'),
(53, 11, 'USPS', '2022-06-25', 'Delivered'),
(54, 11, 'DHL', '2023-09-13', 'Delivered'),
(55, 11, 'Local Delivery', '2024-02-04', 'Delivered'),

-- Customer 12 orders
(56, 12, 'DHL', '2020-05-09', 'Delivered'),
(57, 12, 'FedEx', '2021-08-23', 'Delivered'),
(58, 12, 'UPS', '2022-11-15', 'Delivered'),
(59, 12, 'Local Delivery', '2023-01-22', 'Delivered'),
(60, 12, 'USPS', '2024-03-13', 'Delivered'),

-- Customer 13 orders
(61, 13, 'FedEx', '2020-09-03', 'Delivered'),
(62, 13, 'UPS', '2021-10-17', 'Delivered'),
(63, 13, 'DHL', '2022-01-11', 'Delivered'),
(64, 13, 'USPS', '2023-03-31', 'Delivered'),
(65, 13, 'Local Delivery', '2024-02-20', 'Delivered'),

-- Customer 14 orders
(66, 14, 'UPS', '2020-11-19', 'Delivered'),
(67, 14, 'FedEx', '2021-02-04', 'Delivered'),
(68, 14, 'USPS', '2022-03-18', 'Delivered'),
(69, 14, 'DHL', '2023-06-26', 'Delivered'),
(70, 14, 'Local Delivery', '2024-01-07', 'Delivered'),

-- Customer 15 orders
(71, 15, 'DHL', '2020-01-09', 'Delivered'),
(72, 15, 'FedEx', '2021-02-25', 'Delivered'),
(73, 15, 'UPS', '2022-04-12', 'Delivered'),
(74, 15, 'Local Delivery', '2023-07-17', 'Delivered'),
(75, 15, 'USPS', '2024-03-02', 'Delivered'),

-- Customer 16 orders
(76, 16, 'FedEx', '2020-04-24', 'Delivered'),
(77, 16, 'UPS', '2021-07-06', 'Delivered'),
(78, 16, 'DHL', '2022-10-29', 'Delivered'),
(79, 16, 'USPS', '2023-12-21', 'Delivered'),
(80, 16, 'Local Delivery', '2024-03-07', 'Delivered'),

-- Customer 17 orders
(81, 17, 'UPS', '2020-06-15', 'Delivered'),
(82, 17, 'FedEx', '2021-09-10', 'Delivered'),
(83, 17, 'USPS', '2022-12-23', 'Delivered'),
(84, 17, 'DHL', '2023-02-18', 'Delivered'),
(85, 17, 'Local Delivery', '2024-01-27', 'Delivered'),

-- Customer 18 orders
(86, 18, 'DHL', '2020-09-26', 'Delivered'),
(87, 18, 'FedEx', '2021-11-20', 'Delivered'),
(88, 18, 'UPS', '2022-02-03', 'Delivered'),
(89, 18, 'Local Delivery', '2023-04-27', 'Delivered'),
(90, 18, 'USPS', '2024-03-18', 'Delivered'),

-- Customer 19 orders
(91, 19, 'FedEx', '2020-12-10', 'Delivered'),
(92, 19, 'UPS', '2021-02-14', 'Delivered'),
(93, 19, 'DHL', '2022-04-19', 'Delivered'),
(94, 19, 'USPS', '2023-08-23', 'Delivered'),
(95, 19, 'Local Delivery', '2024-02-27', 'Delivered'),

-- Customer 20 orders
(96, 20, 'UPS', '2020-11-03', 'Delivered'),
(97, 20, 'FedEx', '2021-12-15', 'Delivered'),
(98, 20, 'USPS', '2022-03-08', 'Delivered'),
(99, 20, 'DHL', '2023-06-19', 'Delivered'),
(100, 20, 'Local Delivery', '2024-01-12', 'Delivered')

-- SELECT statements to view data
SELECT * FROM Customer;
SELECT * FROM Supplier;
SELECT * FROM Warehouse;
SELECT * FROM Product;
SELECT * FROM Individual_Order;
SELECT * FROM Payment;
SELECT * FROM Customer_Address;
SELECT * FROM Shipping;
SELECT * FROM Store;
SELECT * FROM Department;
SELECT * FROM Employee;


