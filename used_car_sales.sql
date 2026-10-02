CREATE DATABASE used_car_sales;
USE used_car_sales;

-- Cars Table 
CREATE TABLE cars (
    car_id INT PRIMARY KEY,
    brand VARCHAR(50),
    model VARCHAR(50),
    car_year INT,
    fuel_type VARCHAR(20),
    transmission VARCHAR(20),
    mileage DECIMAL(5,2),
    engine_size DECIMAL(4,1),
    price DECIMAL(12,2)
);

-- Sellers Table
CREATE TABLE sellers (
    seller_id INT PRIMARY KEY,
    seller_name VARCHAR(100),
    city VARCHAR(50),
    seller_type VARCHAR(30)
);

-- Sales Table
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    car_id INT,
    seller_id INT,
    sale_date DATE,
    sold_price DECIMAL(12,2),
    buyer_city VARCHAR(50),

    FOREIGN KEY (car_id) REFERENCES cars(car_id),
    FOREIGN KEY (seller_id) REFERENCES sellers(seller_id)
);

-- Insert Cars
INSERT INTO cars VALUES
(1,'Maruti','Swift',2020,'Petrol','Manual',18.5,1.2,650000),
(2,'Hyundai','i20',2019,'Petrol','Manual',17.2,1.2,580000),
(3,'Honda','City',2021,'Petrol','Automatic',16.5,1.5,1050000),
(4,'Tata','Nexon',2020,'Diesel','Manual',20.0,1.5,750000),
(5,'Toyota','Fortuner',2018,'Diesel','Automatic',12.5,2.8,2800000),
(6,'Mahindra','Thar',2022,'Diesel','Manual',15.2,2.0,1350000),
(7,'Kia','Seltos',2021,'Petrol','Automatic',16.8,1.5,1250000),
(8,'Maruti','Baleno',2019,'Petrol','Manual',19.5,1.2,520000),
(9,'Hyundai','Creta',2020,'Diesel','Automatic',18.0,1.5,1150000),
(10,'Honda','Amaze',2018,'Diesel','Manual',21.0,1.5,600000),
(11,'Tata','Harrier',2021,'Diesel','Automatic',14.8,2.0,1450000),
(12,'MG','Hector',2020,'Petrol','Automatic',13.2,1.5,1300000),
(13,'Maruti','WagonR',2017,'Petrol','Manual',21.5,1.0,380000),
(14,'Hyundai','Verna',2019,'Petrol','Automatic',17.5,1.6,720000),
(15,'Toyota','Innova',2018,'Diesel','Manual',15.0,2.4,1450000);

-- Insert Sellers
INSERT INTO sellers VALUES
(101,'Amit Cars','Lucknow','Dealer'),
(102,'Sharma Motors','Delhi','Dealer'),
(103,'Raj Auto','Kanpur','Individual'),
(104,'City Cars','Lucknow','Dealer'),
(105,'Verma Automobiles','Agra','Dealer'),
(106,'Singh Cars','Varanasi','Individual');

-- Insert Sales
INSERT INTO sales VALUES
(1001,1,101,'2025-01-15',620000,'Lucknow'),
(1002,2,102,'2025-01-20',550000,'Delhi'),
(1003,3,103,'2025-02-10',1010000,'Kanpur'),
(1004,4,104,'2025-02-18',720000,'Lucknow'),
(1005,5,105,'2025-03-05',2700000,'Agra'),
(1006,6,106,'2025-03-22',1320000,'Varanasi'),
(1007,7,101,'2025-04-10',1200000,'Lucknow'),
(1008,8,102,'2025-04-25',500000,'Delhi'),
(1009,9,104,'2025-05-12',1100000,'Lucknow'),
(1010,10,103,'2025-05-30',570000,'Kanpur'),
(1011,11,105,'2025-06-08',1400000,'Agra'),
(1012,12,101,'2025-06-20',1250000,'Lucknow'),
(1013,13,106,'2025-07-15',350000,'Varanasi'),
(1014,14,102,'2025-08-05',700000,'Delhi'),
(1015,15,105,'2025-08-25',1380000,'Agra');


-- =========================
-- ANALYSIS QUERIES
-- =========================

-- 1. Total Cars
SELECT COUNT(*) AS total_cars
FROM cars;

-- 2. Average Car Price
SELECT ROUND(AVG(price),2) AS average_price
FROM cars;

-- 3. Highest Priced Car
SELECT *
FROM cars
ORDER BY price DESC
LIMIT 1;

-- 4. Lowest Priced Car
SELECT *
FROM cars
ORDER BY price ASC
LIMIT 1;

-- 5. Brand-wise Cars
SELECT brand, COUNT(*) AS total_cars
FROM cars
GROUP BY brand
ORDER BY total_cars DESC;

-- 6. Average Price by Brand
SELECT brand, ROUND(AVG(price),2) AS average_price
FROM cars
GROUP BY brand
ORDER BY average_price DESC;

-- 7. Fuel Type Analysis
SELECT fuel_type, COUNT(*) AS total_cars
FROM cars
GROUP BY fuel_type;

-- 8. Transmission Analysis
SELECT transmission, COUNT(*) AS total_cars
FROM cars
GROUP BY transmission;

-- 9. Total Revenue
SELECT SUM(sold_price) AS total_revenue
FROM sales;

-- 10. Average Selling Price
SELECT ROUND(AVG(sold_price),2) AS average_selling_price
FROM sales;

-- 11. City-wise Sales
SELECT 
    buyer_city,
    COUNT(*) AS cars_sold,
    SUM(sold_price) AS revenue
FROM sales
GROUP BY buyer_city
ORDER BY revenue DESC;

-- 12. Car and Sale Details
SELECT
    c.brand,
    c.model,
    c.car_year,
    c.fuel_type,
    s.sold_price,
    s.sale_date,
    s.buyer_city
FROM cars c
JOIN sales s
ON c.car_id = s.car_id;

-- 13. Seller-wise Revenue
SELECT
    se.seller_name,
    COUNT(s.sale_id) AS cars_sold,
    SUM(s.sold_price) AS revenue
FROM sellers se
JOIN sales s
ON se.seller_id = s.seller_id
GROUP BY se.seller_id, se.seller_name
ORDER BY revenue DESC;

-- 14. Price Difference
SELECT
    c.brand,
    c.model,
    c.price AS listed_price,
    s.sold_price,
    (s.sold_price - c.price) AS price_difference
FROM cars c
JOIN sales s
ON c.car_id = s.car_id;

-- 15. Cars Sold Above Listed Price
SELECT
    c.brand,
    c.model,
    c.price,
    s.sold_price
FROM cars c
JOIN sales s
ON c.car_id = s.car_id
WHERE s.sold_price > c.price;

-- 16. Year-wise Sales
SELECT
    YEAR(sale_date) AS sale_year,
    COUNT(*) AS total_sales,
    SUM(sold_price) AS revenue
FROM sales
GROUP BY YEAR(sale_date);

-- 17. Monthly Revenue
SELECT
    MONTH(sale_date) AS month,
    SUM(sold_price) AS revenue
FROM sales
GROUP BY MONTH(sale_date)
ORDER BY month;

-- 18. Cars Above Average Price
SELECT *
FROM cars
WHERE price > (
    SELECT AVG(price)
    FROM cars
);

-- 19. Top 5 Expensive Cars
SELECT brand, model, price
FROM cars
ORDER BY price DESC
LIMIT 5;

-- 20. Rank Cars by Price
SELECT
    brand,
    model,
    price,
    RANK() OVER (ORDER BY price DESC) AS price_rank
FROM cars;


-- =========================
-- VIEW
-- =========================

CREATE VIEW sales_report AS
SELECT
    c.brand,
    c.model,
    c.fuel_type,
    c.transmission,
    c.price AS listed_price,
    s.sold_price,
    s.sale_date,
    s.buyer_city
FROM cars c
JOIN sales s
ON c.car_id = s.car_id;

SELECT * FROM sales_report;
