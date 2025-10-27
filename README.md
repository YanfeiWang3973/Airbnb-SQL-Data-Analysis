# 🏠 Airbnb Market Insights with SQL

This project explores Airbnb listings, availability, and pricing data using MySQL.  
It simulates a real-world data analytics workflow — from database creation and CSV ingestion to generating actionable business insights.

---

## 📊 Project Overview

**Goal:**  
Analyze short-term rental supply, demand, and pricing strategy using SQL.  

**Key Objectives:**
1. Identify total number of unique Airbnb listings and time coverage.
2. Measure booking availability to find fully available or fully booked properties.
3. Determine the most saturated cities and busiest streets.
4. Analyze hosts’ pricing behavior — comparing weekday vs weekend rates.

---

## 🧠 Dataset

Public Airbnb dataset:  
[https://weclouddata.s3.amazonaws.com/datasets/hotel/airbnb/airbnb.zip](https://weclouddata.s3.amazonaws.com/datasets/hotel/airbnb/airbnb.zip)

**Tables Created:**
- `listings` – listing and host details (location, capacity, pricing, etc.)  
- `calendar` – daily availability and pricing for each listing  
- `reviews` – customer reviews and feedback  

---

## ⚙️ Tools and Skills

- **SQL / MySQL**: Data modeling, aggregation, subqueries, CASE logic  
- **Data Cleaning**: Standardizing street names, removing currency symbols  
- **ETL**: CSV ingestion via `LOAD DATA LOCAL INFILE`  
- **Business Analytics**: Market saturation, occupancy, pricing patterns  

---

## 🔍 Insights Generated

| Question | What It Shows | Key Finding |
|-----------|----------------|--------------|
| Unique listings | Total market coverage | 3,585 unique listings |
| Date span | Data range in calendar | 2016 → 2017 |
| Fully available listings | Long-term rental potential | 7,170 listings available all year |
| Fully booked listings | Occupancy pressure | 7,170 listings sold out |
| City with most listings | Market concentration | Boston |
| Street with most listings | Hotspot area | Boylston Street (128 listings) |
| Weekend vs Weekday pricing | Revenue strategy | 2,861 listings change price on weekends |

---

## 🗂️ File Structure

