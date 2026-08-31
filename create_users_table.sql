-- SQL Script to create Users table in EcommerceDB
-- Database: SQL Server

USE EcommerceDB;
GO

-- Create Users table if it does not exist
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Users')
BEGIN
    CREATE TABLE Users (
        UserID INT IDENTITY(1,1) PRIMARY KEY,
        Username NVARCHAR(50) NOT NULL UNIQUE,
        Password NVARCHAR(255) NOT NULL,
        FullName NVARCHAR(100),
        Email NVARCHAR(100),
        Role NVARCHAR(20) NOT NULL DEFAULT 'USER' -- 'ADMIN' or 'USER'
    );
END
GO

-- Insert default seed accounts if table is empty
IF NOT EXISTS (SELECT 1 FROM Users WHERE Username = 'admin')
BEGIN
    INSERT INTO Users (Username, Password, FullName, Email, Role) 
    VALUES ('admin', 'admin123', 'System Administrator', 'admin@vclshop.com', 'ADMIN');
END

IF NOT EXISTS (SELECT 1 FROM Users WHERE Username = 'user')
BEGIN
    INSERT INTO Users (Username, Password, FullName, Email, Role) 
    VALUES ('user', 'user123', 'Regular User', 'user@vclshop.com', 'USER');
END
GO
