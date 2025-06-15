# Data Engineering Assessment – Kimball DWH Implementation


This repository contains the implementation of a Data Warehouse solution using the Kimball methodology. It was developed as part of a data engineering assessment, leveraging an `invoices.xls` file as source data. The goal was to design a dimensional model, implement an ETL pipeline, handle data quality issues, and generate meaningful reporting aggregations.


## 📌 Objective
- Design a star-schema Data Warehouse using Kimball best practices
- Implement a full ETL pipeline in Python
- Populate the data warehouse into a SQL Server instance
- Detect and handle data abnormalities
- Deliver useful reporting aggregations

## 🛠 Technologies Used
- **Python** (Pandas, SQLAlchemy, pyodbc)
- **SQL Server / MSSQL**
- **Jupyter Notebooks**
- **Kimball dimensional modeling**

## 📂 Repository Structure
├── src/         → SQL scripts and parameters  
├── notebooks/   → ETL pipeline in Jupyter Notebook  
├── docs/        → Architecture & data model diagrams  
├── data/        → Input data file  
├── output/      → Reporting queries  
├── report.pdf   → Detailed documentation  
└── README.md


## 🧱 Schema Overview
- **Fact Table:** FactSales (quantities, pricing, total_amount)
- **Dimension Tables:** DimCustomer, DimProduct, DimInvoice, DimDate, DimTime
- **Staging Table:** FactSales_Staging

<p align="center">
  <img src="docs/star_schema.png" alt="Star Schema" width="600"/>
</p>

## 🔄 ETL Pipeline
The ETL process is implemented in `notebooks/etl.ipynb` and follows a modular architecture:

1. **Extract**: Read the source CSV file and load into a staging area.
2. **Transform**: Clean data, enrich columns (e.g., continent, product category), and prepare dimensions.
3. **Load**: Insert into staging and dimensional tables using surrogate keys.
4. **Surrogate Resolution**: Load into final fact table after joining with dimensions.

<p align="center">
  <img src="docs/etl_arch.png" alt="ETL Architecture" width="600"/>
</p>


## 🧼 Data Quality & Assumptions
Handled via transformations in the ETL script:
- Null values in `Price`, `CustomerID`, `Country` cleaned or defaulted.
- Product categories inferred by keyword mapping.
- `InvoiceID` starting with "C" marked as returns.
- Discount rows identified via `StockCode = 'D'` and `Quantity < 0`.

See detailed explanation in `report.pdf`.


## 📊 Reporting Aggregations
SQL queries demonstrating the warehouse's utility:
1. Top 10 customers by quantity purchased
2. Total sales per month & product category
3. Return rate per country

All queries operate on the final fact table (`FactSales`) using joins to dimensions.

## 📝 License
Distributed under the [MIT License](LICENSE).