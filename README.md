# 📱 Flipkart Mobile Sales Data Warehouse Project – Using Snowflake

# 📊 Overview

This project demonstrates how to build a data warehouse and analytics solution for Flipkart mobile phone sales using Snowflake. It includes data ingestion, cleaning, transformation, analysis, and visualization (with Snowsight and Streamlit).

# ✅ Project Goals

- Load and manage Flipkart mobile sales data,
- Handle NULL values and clean the dataset
Remove duplicates and ensure data quality
Store analytical results using best practices
Create interactive dashboards directly in Snowflake using Streamlit

# 🏗️ Architecture

CSV File (Raw Data) → Snowflake Table (Staging) → Clean Table (Final) → Snowsight Charts / Streamlit Dashboard

# 📁 Sample Dataset Schema
Column	Type	Description
Brand	STRING	Mobile brand name
Model	STRING	Model name
Color	STRING	Color variant
Memory	STRING	RAM configuration (e.g., 6GB)
Storage	STRING	Internal storage (e.g., 128GB)
Rating	FLOAT	Customer rating (out of 5)
Selling_Price	FLOAT	Discounted price
Original_Price	FLOAT	Original MRP

# 🧹 Data Cleaning & Transformation
Used COALESCE() to handle nulls
Added discount_percent column:
ROUND((original_price - selling_price) / NULLIF(original_price, 0) * 100, 2)

# 📈 Visualizations in Snowflake
Snowsight (Worksheets):
Total Products
Average Selling Price by Brand
Rating Distribution
Discount % by Brand

# Streamlit in Snowflake:
Brand & Rating Filters
KPIs (Product Count, Avg. Price, Avg. Discount)
Bar Charts & Histograms
