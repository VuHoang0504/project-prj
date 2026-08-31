USE EcommerceDB;
GO

INSERT INTO Products (ProductName, Description, ProductType, Price, ImageURL)
VALUES 
(
    N'MacBook Pro 16-inch M3 Max', 
    N'Apple M3 Max chip with 16-core CPU and 40-core GPU, 48GB Unified Memory, 1TB SSD Storage, Liquid Retina XDR display.', 
    N'Laptop', 
    3499.00, 
    N'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&w=800&q=80'
),
(
    N'Samsung Galaxy S24 Ultra', 
    N'200MP Quad Telephoto Camera, Snapdragon 8 Gen 3 for Galaxy, Galaxy AI features, Built-in S Pen, Titanium Frame.', 
    N'Smartphone', 
    1299.00, 
    N'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?auto=format&fit=crop&w=800&q=80'
),
(
    N'Dell XPS 15 OLED', 
    N'13th Gen Intel Core i9-13900H, NVIDIA GeForce RTX 4070, 32GB DDR5 RAM, 1TB NVMe SSD, 15.6-inch 3.5K OLED Touch Display.', 
    N'Laptop', 
    1899.00, 
    N'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?auto=format&fit=crop&w=800&q=80'
),
(
    N'iPad Pro 12.9-inch M2', 
    N'Apple M2 chip, Liquid Retina XDR display with ProMotion, 256GB Storage, Wi-Fi 6E, supports Apple Pencil 2nd gen.', 
    N'Tablet', 
    1099.00, 
    N'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?auto=format&fit=crop&w=800&q=80'
),
(
    N'Sony WH-1000XM5 Wireless Headphones', 
    N'Industry-leading noise canceling with two processors and 8 microphones, up to 30-hour battery life, ultra-comfortable design.', 
    N'Headphones', 
    399.00, 
    N'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=800&q=80'
),
(
    N'Apple Watch Ultra 2', 
    N'49mm titanium case, brightest Apple display ever, Precision Dual-Frequency GPS, up to 36 hours battery life for outdoor adventure.', 
    N'Smartwatch', 
    799.00, 
    N'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?auto=format&fit=crop&w=800&q=80'
),
(
    N'Asus ROG Zephyrus G16 Gaming Laptop', 
    N'Intel Core Ultra 9 185H, NVIDIA GeForce RTX 4080, 2.5K 240Hz ROG Nebula OLED display, CNC Aluminum Unibody.', 
    N'Laptop', 
    2199.00, 
    N'https://images.unsplash.com/photo-1603302576837-37561b2e2302?auto=format&fit=crop&w=800&q=80'
),
(
    N'Google Pixel 8 Pro', 
    N'Google Tensor G3 processor, pro-level triple camera system with Super Res Zoom, 6.7-inch Super Actua display, 128GB Storage.', 
    N'Smartphone', 
    999.00, 
    N'https://images.unsplash.com/photo-1598327105666-5b89351aff97?auto=format&fit=crop&w=800&q=80'
),
(
    N'Bose QuietComfort Ultra Headphones', 
    N'World-class noise cancellation, breakthrough spatialized audio, CustomTune technology for personalized sound, 24-hour battery.', 
    N'Headphones', 
    429.00, 
    N'https://images.unsplash.com/photo-1546435770-a3e426bf472b?auto=format&fit=crop&w=800&q=80'
),
(
    N'Keychron Q1 Pro Wireless Mechanical Keyboard', 
    N'QMK/VIA custom wireless mechanical keyboard, full aluminum body, double-gasket design, hot-swappable switches, RGB backlight.', 
    N'Accessories', 
    199.00, 
    N'https://images.unsplash.com/photo-1587829741301-dc798b83add3?auto=format&fit=crop&w=800&q=80'
);
GO
