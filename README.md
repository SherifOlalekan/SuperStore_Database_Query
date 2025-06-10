# 🛒 Superstore SQL Project

This repository contains a SQL script to set up and analyze a **Superstore sales** dataset using Microsoft SQL Server. It includes database creation, table creation, data import from Excel, and several analytical queries.

## 📂 File Structure

- `Superstore query.sql`  
  SQL script that:
  - Creates the `Superstore_DB` database
  - Defines three tables: `Orders`, `Returns`, and `Users`
  - Imports data from an Excel file
  - Runs SQL queries for sales analysis

## 🧰 Requirements

- Microsoft SQL Server
- Microsoft Access Database Engine (OLEDB provider)
- `Superstore.xlsx` located at:  
  `C:\Users\HP\Desktop\Superstore.xlsx`
- Enable `Ad Hoc Distributed Queries`

> 💡 Tip: If you're not using this exact file path, update it in the script accordingly.

---

## 🏗️ Database Structure

### 📌 Database: `Superstore_DB`

### 📊 Tables:

- `Orders`: Contains order-level details (sales, profit, shipping, product info, etc.)
- `Returns`: Contains returned order IDs and their return status
- `Users`: Maps regions to managers

---

## 📥 Data Import Steps

The script uses `OPENROWSET` to import data from Excel sheets (`Orders$`, `Returns$`, and `Users$`).

### ⚙️ Enable `OPENROWSET` (Run Before Script):

```sql
sp_configure 'show advanced options', 1;
RECONFIGURE;
sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;
