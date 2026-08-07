# CMS Inpatient Hospital Pricing & Reimbursement Analytics

An executive financial intelligence dashboard analyzing the gap between hospital list prices (**Chargemaster charges**) and actual revenue collected (**Medicare settlements**) across U.S. inpatient facilities.

---

## 📌 Executive Summary

U.S. hospitals charge list prices that rarely reflect the actual money they collect. Using **145,879 inpatient claim records** from the **Centers for Medicare & Medicaid Services (CMS)**, this project evaluates pricing behavior, markup ratios, and out-of-pocket patient risk across **2,906 hospitals** and **540 medical diagnoses (DRGs)**.

### Key Financial Highlights
* **$457.65 Billion** in gross billed charges across **4,952,481 discharges**.
* **$90.93 Billion** in total realized payments collected (a **19.87%** cash realization rate).
* **5.03x** national average markup multiplier (hospitals bill **$5.03** for every **$1.00** collected).
* **$15.82 Billion** out-of-pocket patient exposure gap left unpaid by Medicare.
* **Extreme Outliers:** Certain acute care hospitals marked up prices by more than **20x** above collected payments.

---

## 📐 Data Architecture & Modeling

The raw CMS file (`MUP_INP_RY26_P03_V10_DY24_PrvSvc.CSV`) was transformed in **Power Query** into a normalized **Star Schema** to optimize query performance and prevent data duplication.

```text
               +-----------------------------------+
               |             Dim_DRG               |
               +-----------------------------------+
               | PK: DRG_Cd                        |
               | Attributes: DRG_Desc              |
               +-----------------------------------+
                                 | (1)
                                 |
                                 | (*)
+-------------------------------------------------------------------+
|                       Fact_InpatientClaims                        |
+-------------------------------------------------------------------+
| FK: Rndrng_Prvdr_CCN                                              |
| FK: DRG_Cd                                                        |
| Metrics: Tot_Dschrgs, Avg_Submtd_Cvrd_Chrg,                       |
|          Avg_Tot_Pymt_Amt, Avg_Mdcr_Pymt_Amt                     |
+-------------------------------------------------------------------+
                                 | (*)
                                 |
                                 | (1)
               +-----------------------------------+
               |           Dim_Hospital            |
               +-----------------------------------+
               | PK: Rndrng_Prvdr_CCN              |
               | Attributes: Rndrng_Prvdr_Org_Name,|
               |             City, State, Zip, RUCA|
               +-----------------------------------+