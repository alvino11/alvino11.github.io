# SEC EDGAR Corporate Financial Analysis & DuPont ROE Pipeline (SQL)

## 📌 Project Overview
This project builds an automated, end-to-end relational data pipeline using **Microsoft SQL Server Management Studio (SSMS)** to ingest, transform, and analyze **28+ million raw financial records** sourced from the **U.S. Securities and Exchange Commission (SEC EDGAR)**. 

By parsing unstructured XBRL datasets across 8 consecutive fiscal quarters, the pipeline extracts key US-GAAP accounting metrics and deconstructs **Return on Equity (ROE)** for **Apple Inc. (AAPL)**, **Microsoft Corp. (MSFT)**, and **Tesla, Inc. (TSLA)** using the **3-Step DuPont Identity Framework**.

---

## 🏗️ Financial Framework
The **DuPont Identity** deconstructs Return on Equity into three distinct operational and financial efficiency drivers:

$$\text{ROE} = \text{Net Profit Margin} \times \text{Asset Turnover} \times \text{Equity Multiplier}$$

$$\text{ROE} = \left( \frac{\text{Net Income}}{\text{Revenue}} \right) \times \left( \frac{\text{Revenue}}{\text{Total Assets}} \right) \times \left( \frac{\text{Total Assets}}{\text{Stockholders' Equity}} \right)$$

1. **Net Profit Margin:** Measures operational efficiency and pricing power.
2. **Asset Turnover:** Measures capital utilization efficiency in generating sales.
3. **Equity Multiplier:** Measures financial leverage and debt dependency.

---

### 📊 Consolidated Analysis Findings (Annual FY Reports)

| Company | Fiscal Year | Period End | Net Income ($B) | Revenue ($B) | Total Assets ($B) | Total Equity ($B) | Net Profit Margin | Asset Turnover | Equity Multiplier | Calculated ROE |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **Apple Inc.** | 2025 | 2025-09-30 | $112.01 | $416.16 | $359.24 | $93.57 | **26.92%** | **1.1584x** | **3.8394x** | **119.71%** |
| **Apple Inc.** | 2024 | 2024-09-30 | $93.74 | $391.04 | $364.98 | $83.28 | **23.97%** | **1.0714x** | **4.3828x** | **112.56%** |
| **Microsoft Corp** | 2025 | 2025-06-30 | $101.83 | $281.72 | $619.00 | $343.48 | **36.15%** | **0.4551x** | **1.8022x** | **29.65%** |
| **Microsoft Corp** | 2024 | 2024-06-30 | $88.14 | $245.12 | $512.16 | $268.48 | **35.96%** | **0.4786x** | **1.9077x** | **32.83%** |
| **Tesla, Inc.** | 2025 | 2025-12-31 | $3.79 | $94.83 | $137.81 | $82.14 | **4.00%** | **0.6881x** | **1.6778x** | **4.62%** |
| **Tesla, Inc.** | 2024 | 2024-12-31 | $7.09 | $97.69 | $122.07 | $72.91 | **7.26%** | **0.8003x** | **1.6742x** | **9.73%** |

--

## 🔍 Key Financial & Strategic Insights

* **Apple’s Leverage-Driven ROE Strategy (>110%):**
  * Apple exhibits a significantly elevated **Equity Multiplier ($3.84\text{x} - 4.38\text{x}$)** compared to peers.
  * *Business Driver:* Apple’s aggressive share buyback strategy systematically reduces its shareholder equity base relative to assets, multiplying Return on Equity to over **119%**.

* **Microsoft’s High-Margin Efficiency Engine:**
  * Microsoft leads the cohort in **Net Profit Margin ($\approx 36\%$)**, driven by enterprise cloud software profitability.
  * *Business Driver:* High operating margins offset a lower asset turnover rate ($0.45\text{x}$), delivering a strong, stable ROE ($\approx 29.65\%$) with low financial leverage ($1.80\text{x}$).

* **Tesla’s Capital Intensity & Margin Pressure:**
  * Tesla displays a lower **ROE ($4.62\%$ in FY2025)**, impacted by compressing profit margins ($4.00\%$) and the heavy asset base required for vehicle production and infrastructure expansions.

---

## 🛠️ Technologies & SQL Concepts Used

* **Database Engine:** Microsoft SQL Server (SSMS)
* **Language:** T-SQL (Transact-SQL)
* **Dynamic SQL Cursors:** Automated dynamic bulk loading loops across multi-quarter folder directories.
* **Bulk Data Parsing:** Configured custom hex line-feed parameters (`ROWTERMINATOR = '0x0a'`) to accurately process Unix-style flat files.
* **Clustered Indexing:** Applied index optimizations on primary/foreign join keys (`adsh`, `tag`) to reduce query times across 28M+ rows from minutes to sub-second execution.
* **CTEs & Conditional Aggregation:** Utilized multi-stage Common Table Expressions and `MAX(CASE WHEN...)` statements to pivot vertical XBRL accounting tags into horizontal columns.
* **Window Functions:** Employed `ROW_NUMBER() OVER (PARTITION BY ...)` to handle multi-filing amendments and remove SEC restatements.
* **Defensive Calculations:** Implemented `NULLIF()` across ratio division routines to prevent fatal divide-by-zero execution errors.

---

## 📁 Repository Structure

```text
sql-sec-dupont-analysis/
├── 01_schema_creation.sql          -- DDL statements for staging tables (dbo.sub, dbo.num)
├── 02_data_ingestion.sql            -- Dynamic T-SQL cursor for bulk loading 8 quarterly files
├── 03_indexing_and_verification.sql -- Clustered index creation and audit row counts
├── 04_dupont_analysis.sql           -- Analytical query for DuPont ROE calculations
├── 05_final_deduplicated_output.sql -- Final CTE pipeline with restatement deduplication ($B)
├── data/
│   └── dupont_analysis_results.csv  -- Final exported query results
└── README.md                        -- Project documentation
