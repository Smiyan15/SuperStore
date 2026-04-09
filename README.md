# Superstore Sales & Revenue Analytics Pipeline

## Project Overview
An end-to-end data analytics pipeline analyzing 4 years of sales data 
from a fictional superstore. The goal was to uncover revenue trends, 
identify unprofitable products, and deliver actionable business insights 
through SQL analysis and Tableau dashboards.

## Tech Stack
- **Python (Pandas)** — Data cleaning & ETL
- **MySQL** — Data warehousing & SQL analysis
- **Tableau Public** — Interactive dashboards

## Dataset
- Source: Sample Superstore Dataset
- 9,994 rows | 22 columns
- Covers 2014–2017 sales across 4 US regions

## What I Built
### 1. ETL Pipeline (Python)
- Extracted raw CSV data
- Cleaned column names, fixed date formats, removed duplicates
- Engineered new features: profit margin, days to ship, 
  order year/month
- Loaded clean data into MySQL database

### 2. SQL Analysis (7 Business Questions)
- Executive summary — total revenue, profit, orders, margin
- Regional performance breakdown
- Top 10 products by revenue
- Month over month revenue trend using Window Functions (LAG)
- Loss-making products using HAVING clause
- Customer segment analysis
- Shipping mode efficiency analysis

### 3. Tableau Dashboard (coming soon)
- Executive summary KPI cards
- Monthly revenue trend
- Regional performance map
- Product profitability analysis

## Key Findings
- Overall profit margin is only 12% despite $2.3M in revenue
- Central region has a -10.41% margin — the only loss-making region
- 6 out of top 10 revenue products are unprofitable
- Machines sub-category drives the highest losses (-$17,000+)
- Home Office segment has the highest margin at 14.29%
- Second Class shipping is the most profitable shipping mode at 15.02%

## How to Run
1. Clone this repository
2. Install dependencies: `pip install pandas sqlalchemy 
   mysql-connector-python`
3. Create MySQL database: `CREATE DATABASE superstore_db;`
4. Run ETL script: `python etl_superstore.py`
5. Run SQL queries in `superstore_analysis.sql`
