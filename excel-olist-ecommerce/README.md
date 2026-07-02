# Brazilian E-Commerce (Olist) Business Intelligence Dashboard
An Executive Data Analysis & Interactive Dashboard Portfolio Project identifying revenue drivers, regional growth trends, and transactional optimizations for Brazil's largest e-commerce marketplace integrator.

---

## 📸 Dashboard Showcase
![Olist E-Commerce Analytics Dashboard Preview](../assets/screenshots/excel-dashboard.png)

*   **Goal:** Demystify e-commerce marketplace operations for Brazil's largest platform integrator (Olist) by consolidating over 99,000 fragmented relational order records into a centralized executive dashboard that tracks revenue velocity, regional growth drivers, and payment channel distribution.
*   **Approach:** Cleaned and modeled raw multi-table relational datasets using **Power Query** to establish an optimal star schema. Engineered performant aggregation layers using **PivotTables**, implemented dynamic **KPI Summary Cards** via cross-sheet formula mapping, and deployed an interactive sidebar panel containing globally linked **Slicers and Timelines** to enable seamless cross-filtering across all visual elements.
*   **Outcome:** Successfully mapped regional economic engines, identifying that **São Paulo (SP)** anchors the highest ecosystem value at **$8.01M**, outperforming secondary hubs like **Rio de Janeiro (RJ)** ($2.90M) and **Minas Gerais (MG)** ($2.42M). Isolated major consumer trends showing that **Health & Beauty** leads sector revenue at **$1.71M** and that credit lines heavily dominate platform velocity, capturing **$16.05M** in total processing volume compared to **$4.08M** via traditional bank invoices (*Boleto*).

**Skills demonstrated:** `Excel` `PivotTables` `Power Query` `Data Cleaning` `KPI Dashboards`

---

## 📌 Executive Business Summary
This project analyzes the end-to-end commercial operations of Olist, a major Brazilian e-commerce marketplace platform connecting small businesses to larger retail channels. Utilizing advanced data preparation pipeline workflows, this analysis consolidates complex relational datasets comprising over **99,000 orders** from 2016 to 2018. 

The objective was to decode regional marketplace dynamics, capture consumer purchasing behaviors over time, and isolate logistical or payment-processing friction points to deliver data-backed strategic recommendations for leadership.

### Key Macro Performance Indicators (KPIs) Captured:
* **Total Volume Handled:** 99,441 Fulfilling Orders
* **Ecosystem Scale:** 96,096 Unique Customers engaged across Brazil
* **Merchant Network Density:** 3,096 Active Commercial Sellers
* **Primary State Market Share:** São Paulo (SP) driving $8.01M in Gross Revenue

---

## 💡 Core Business Questions Answered
To drive actionable insight rather than raw observations, the data architecture was queried and structured to address four fundamental business dilemmas:

1.  **Temporal Growth & Seasonality Trajectory:** *What do the macro-transactional growth trends reveal about monthly sales velocity and scalability? Are there explicit operational seasonal surges or critical data reporting anomalies?*
2.  **Product Category Portfolio Performance:** *Which high-value product categories dominate the marketplace revenue share? Where should marketing acquisition efforts focus to scale average order value (AOV)?*
3.  **Geographic Revenue Densities:** *How is consumer demand decentralized across Brazilian states? Which regions represent the highest-performing revenue anchors versus under-indexed markets?*
4.  **Transaction & Friction Processing Optimization:** *What is the preferred payment mechanism for the consumer base? How significantly do split/alternative financing methods (like Credit Cards vs. Boleto banking invoices) dictate total platform volume?*

---

## 🛠️ Data Engineering & Analytical Methodology
The workflow transformed raw transactional data into high-fidelity executive visualizations using an advanced multi-layered architecture:

1.  **ETL & Relational Modeling (Power Query):** Cleaned, merged, and established schema relationships between detached dimensional entities (`Orders`, `Customers`, `Sellers`, `Order_payments`, and `Products`) into a streamlined star-schema architecture.
2.  **Aggregation Engine (Pivot Tables):** Built isolated, performant analytics matrix engines to calculate exact month-over-month sales trends, payment profile share distributions, and geographic performance.
3.  **Human-Centered Dashboard Interface UI Design:** 
    * Constructed unified **KPI Summary Cards** mapping top-tier macro metrics with dynamic cell references.
    * Applied a rigid **60-30-10 Color Hierarchy Style Guide** leveraging deep slate corporate branding tones paired with intentional data callouts, eliminating visual noise.
    * Deployed a horizontal axis design structure for ranking metrics to preserve textual readability.
    * Engineered interconnected **Global Slicers and Timelines** across the analytical layer, creating an interactive user application.

---

## 📊 Key Data Insights & Analytical Findings

### 1. Market Penetration & Regional Dominance
* The State of **São Paulo (SP)** serves as the economic engine of the ecosystem, contributing over **$8.01 Million** in gross revenue. This dramatically eclipses secondary regional hubs including **Rio de Janeiro (RJ)** at **$2.90 Million** and **Minas Gerais (MG)** at **$2.42 Million**.
* *Strategic Takeaway:* Supply chain routing, dedicated merchant onboarding programs, and regional localized marketing capital should remain heavily weighted toward the high-yielding SP-RJ-MG logistics triangle.

### 2. Category Performance Mix
* Commercial volume is dominated by wellness, domestic infrastructure, and lifestyle verticals. **Health & Beauty** represents the largest individual revenue generation pillar at **$1.71 Million**, closely followed by the **Furniture & Decor** category at **$1.49 Million**, and **Sports & Leisure** anchoring **$1.44 Million**.
* *Strategic Takeaway:* Inventory financing incentives and platform banners should cross-promote complimentary bundles between these adjacent lifestyle and household categories.

### 3. Payment Processing Dynamics
* The Olist consumer infrastructure relies massively on credit lines. **Credit Card** transactions comprise the overwhelming share of financial velocity, processing **$16.05 Million** in total payment volume. 
* **Boleto Bancário** (traditional Brazilian bank invoice slips) stands as the secondary engine processing **$4.08 Million**, while auxiliary mechanisms like **Vouchers** anchor **$0.96 Million**.
* *Strategic Takeaway:* Ensuring seamless, low-latency API connections to major credit card acquirers and optimizing checkout paths for desktop and mobile payment processors is paramount to mitigating cart abandonment.

---

## 📈 Strategic Recommendations for Leadership
1.  **Double Down on Top Regions:** Focus marketing and new merchant sign-ups on the high-performing São Paulo, Rio de Janeiro, and Minas Gerais triangle to maximize return on investment before attempting risky expansions into smaller markets.
2.  **Cut Payment Processing Costs:** Offer small checkout discounts (e.g., 2-5% off) for customers paying with *Boleto* or instant digital methods. This will incentivize users to bypass credit cards ($16.05M in volume) and save the company money on heavy bank processing fees.
3.  **Prepare for Seasonal Holiday Surges:** Use historical sales data to predict annual Q4 holiday shopping spikes. Leadership should scale up server infrastructure and set stricter delivery deadlines for sellers ahead of time to ensure a smooth customer experience.
