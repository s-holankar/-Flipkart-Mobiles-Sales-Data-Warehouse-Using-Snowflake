-- Use specfic warehouse

USE WAREHOUSE COMPUTE_WH;

-- Use database

USE DATABASE FLIPKART_MOBILES;

-- Use schema

USE SCHEMA FLIPKART_MOBILES.PUBLIC;

-- show tables 

SHOW TABLES;

-- Create table using sql statement

create or replace TABLE FLIPKART_MOBILES.PUBLIC.MOBILE_SALES (
	BRAND VARCHAR(16777216),
	MODEL VARCHAR(16777216),
	COLOR VARCHAR(16777216),
	MEMORY VARCHAR(16777216),
	STORAGE VARCHAR(16777216),
	RATING FLOAT,
	SELLING_PRICE NUMBER(38,0),
	ORIGINAL_PRICE NUMBER(38,0)
);

-- show raw table data

SELECT * FROM MOBILE_SALES;

-- Identify NULL Values

SELECT
  COUNT(*) AS total_rows,
  COUNT_IF(STORAGE IS NULL) AS null_storage,
  COUNT_IF(RATING IS NULL) AS null_rating
FROM MOBILE_SALES;  

-- Handle NULLs Using COALESCE()

CREATE OR REPLACE TABLE clean_mobile_sales AS
SELECT
  COALESCE(brand, 'Unknown') AS brand,
  COALESCE(model, 'Unknown') AS model,
  COALESCE(color, 'N/A') AS color,
  COALESCE(memory, 'Unknown') AS memory,
  COALESCE(storage, 'Unknown') AS storage,
  COALESCE(rating, 0) AS rating,
  COALESCE(selling_price, 0) AS selling_price,
  COALESCE(original_price, 0) AS original_price,
FROM mobile_sales;

-- Show clean new table

SELECT * FROM CLEAN_MOBILE_SALES;

-- Most Popular Mobile Brands

SELECT brand, COUNT(*) AS total_brands
FROM clean_mobile_sales
GROUP BY brand
ORDER BY total_brands DESC;

-- Most Popular Mobile Models

SELECT model, COUNT(*) AS total_models
FROM clean_mobile_sales
GROUP BY model
ORDER BY total_models DESC
LIMIT 10;

-- Average Discount % by Brand
SELECT 
  brand,
  ROUND(AVG((original_price - selling_price) / original_price) * 100, 2) AS avg_discount_percent
FROM clean_mobile_sales
GROUP BY brand
ORDER BY avg_discount_percent DESC;

-- Top-Rated Models

SELECT DISTINCT(brand), model, rating
FROM clean_mobile_sales
WHERE rating >= 4.5
ORDER BY rating DESC;

-- Price Distribution by RAM (Memory)

SELECT memory, 
       ROUND(AVG(selling_price), 2) AS avg_price, 
       COUNT(*) AS device_count
FROM clean_mobile_sales
GROUP BY memory
ORDER BY avg_price DESC;


