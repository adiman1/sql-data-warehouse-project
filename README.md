# 📦 Data Warehouse and Analytics Project

Welcome to the **Data Warehouse and Analytics Project** repository!   
This project demonstrates a complete data warehousing and analytics solution — from ingesting raw data to delivering business insights — following industry best practices in **data engineering**, **ETL**, and **data modeling**.

---

## 🏗 Data Architecture

The project follows the **Medallion Architecture** consisting of three layers:

- **Bronze Layer**:  
  Stores raw data as-is from source systems. In this project, data is ingested from CSV files into a SQL Server database.

- **Silver Layer**:  
  Performs cleansing, standardization, and normalization to transform data for downstream consumption.

- **Gold Layer**:  
  Houses business-ready data modeled in a **star schema**, optimized for reporting and analytical queries.

---

## 📖 Project Overview

This repository covers:

- **Data Architecture**:  
  Designing and implementing a layered architecture (Bronze, Silver, Gold).

- **ETL Pipelines**:  
  Building SQL-based pipelines to extract, transform, and load data into the warehouse.

- **Data Modeling**:  
  Creating star schemas with fact and dimension tables optimized for analytics.

- **Analytics & Reporting**:  
  Writing SQL queries and dashboards to generate insights on sales, customers, and products.

---

## 🎯 Skills Demonstrated

This project is ideal for showcasing skills in:

- SQL Development  
- Data Architecture  
- Data Engineering  
- ETL Pipeline Development  
- Data Modeling  
- Data Analytics  

---

## 🛠️ Tools & Resources

All tools and resources used in this project are **free** and beginner-friendly:

- 📂 **Datasets**: CSV files containing sales and customer data  
- 🖥️ **SQL Server Express**: Free lightweight version of SQL Server  
- 🧠 **SQL Server Management Studio (SSMS)**: GUI for managing databases  
- 💻 **GitHub**: Version control, code management, and collaboration  
- 📊 **DrawIO**: Used for data architecture and model diagrams  
- 📝 **Notion**: Project management and documentation (Project template included)  

---

## 🚀 Project Requirements

### 📦 Data Engineering (Build the Data Warehouse)

**Objective**:  
Design a modern data warehouse using SQL Server to integrate sales data for business analysis.

**Key Specs**:
- **Data Sources**: ERP and CRM data (CSV)
- **Data Quality**: Clean and normalize before use
- **Integration**: Merge both sources into a unified analytical model
- **Scope**: Only latest snapshot data (no historization)
- **Documentation**: Provide clear data model references for analysts

---

### 📈 Data Analysis (Analytics & Reporting)

**Objective**:  
Use SQL to generate business insights for:

- Customer Behavior  
- Product Performance  
- Sales Trends  

Empower business users with actionable KPIs for better decision-making.

---

## 📝 License

This project is licensed under the [MIT License](LICENSE).  

