-- 1. TẠO CƠ SỞ DỮ LIỆU
CREATE DATABASE EcommerceDB;
GO

USE EcommerceDB;
GO

-- 2. TẠO CÁC BẢNG (TABLES) DỰA TRÊN CLASS DIAGRAM VÀ UI

-- Bảng lưu trữ thông tin Khách hàng (Customer)
CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerName NVARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    CustomerAddress NVARCHAR(255) NOT NULL,
    CustomerPhone VARCHAR(20) NOT NULL,
    Note NVARCHAR(MAX)
);
GO

-- Bảng lưu trữ thông tin Sản phẩm (Product)
CREATE TABLE Products (
    ProductID BIGINT IDENTITY(1,1) PRIMARY KEY, -- Dùng BIGINT vì Class Diagram ghi là 'long'
    ProductName NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX),
    ProductType NVARCHAR(50),
    Price DECIMAL(18, 0) NOT NULL, -- Dùng DECIMAL để lưu giá VNĐ chính xác
    ImageURL VARCHAR(255) -- Lưu đường dẫn hình ảnh hiển thị trên web
);
GO

-- Bảng lưu trữ thông tin Đơn hàng (Order)
-- Được sinh ra khi user nhấn "Gởi đơn đặt hàng" (Lưu giỏ hàng vào Database)
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(18, 0) NOT NULL,
    Status NVARCHAR(50) DEFAULT N'Pending'
);
GO

-- Bảng lưu trữ Chi tiết Đơn hàng (LineItem / OrderDetails)
-- Lưu từng sản phẩm trong giỏ hàng thuộc về đơn hàng nào
CREATE TABLE OrderDetails (
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID BIGINT FOREIGN KEY REFERENCES Products(ProductID),
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(18, 0) NOT NULL,
    PRIMARY KEY (OrderID, ProductID)
);
GO

-- 3. CHÈN DỮ LIỆU MẪU (INSERT DATA)

-- Thêm các sản phẩm bám sát theo hình ảnh tài liệu và yêu cầu (Laptop, Tablet, Mobile...)
INSERT INTO Products (ProductName, Description, ProductType, Price, ImageURL) VALUES
('Dell XPS 13', '13.3-inch laptop with Intel Core i7...', 'Laptop', 1200, 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=500'),
('iPhone 14 Pro', 'Apple iPhone 14 Pro, 128GB...', 'Smartphone', 999, 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500'),
('Sony WH-1000XM5', 'Wireless noise canceling headphones...', 'Headphones', 398, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500'),
('Samsung Galaxy S23 Ultra', 'Android smartphone with stylus S Pen...', 'Smartphone', 1199, 'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=500'),
('iPad Air 5th Gen', 'Apple iPad Air with Apple M1 chip...', 'Tablet', 599, 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=500'),
('Logitech MX Master 3S', 'Performance wireless mouse...', 'Accessories', 99, 'https://images.unsplash.com/photo-1615663245857-ac93bb7c39e7?w=500');
GO

-- (Tùy chọn) Thêm sẵn một khách hàng mẫu
INSERT INTO Customers (CustomerName, Email, CustomerAddress, CustomerPhone, Note)
VALUES (N'Nguyễn Văn A', 'nva@example.com', N'123 Đường Lê Lợi, Đà Nẵng', '0901234567', N'Giao hàng giờ hành chính');
GO