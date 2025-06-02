# sql-data-warehouse-project
Building a modern Data Warehouse with SQL Server, including ETL processes, data modeling and analytics.

## Overview

The **Gold Layer** represents the business-level data model, designed to support **analytics**, **dashboards**, and **reporting**. It contains curated **dimension** and **fact** tables that are clean, well-structured, and semantically enriched for use by analysts, data scientists, and business stakeholders.

---

## 📁 Tables in Gold Layer

### 1. `gold.dim_customers`

**Purpose:**  
Stores detailed information about customers, enriched with demographic and geographic attributes.

### 2. `gold.dim_products`

**Purpose:**  
Contains product information including categories, pricing, and maintenance requirements.

### 3. `gold.fact_sales`

**Purpose:**  
Captures transactional sales data for quantitative analysis and performance measurement.
---

## 🚀 Usage

This data model is typically used in:
- Business Intelligence dashboards
- KPI reporting
- Customer and product analytics
- Sales performance tracking
---

## 📌 Notes

- All date fields are stored in `DATE` format (YYYY-MM-DD).
- Surrogate keys (`*_key`) are used for dimension joins.
- This layer is designed to be downstream from cleaned and transformed silver-layer data.

---

## 📝 License

This repository is licensed under the [MIT License](LICENSE). 


