-- ===============================================================================
-- PROJECT: SEC Financial Statement Analysis (DuPont Identity Framework)
-- SCRIPT:  final_deduplicated_billions_output.sql
-- PURPOSE: 1. Extract US-GAAP financial statement tags across 8 quarterly filings 
--             for target enterprise CIKs (Apple, Microsoft, Tesla).
--          2. Capture duration-based income tags (qtrs=1,4) and point-in-time 
--             balance sheet snapshots (qtrs=0) to ensure zero metric loss.
--          3. Pivot raw vertical XBRL line items into structured horizontal columns.
--          4. Deconstruct Return on Equity (ROE) using the 3-Step DuPont Identity 
--             (Profit Margin x Asset Turnover x Equity Multiplier) with NULLIF protection.
--          5. Normalize absolute currency metrics into clean, human-readable Billions ($B).
--          6. Deduplicate multi-filings and SEC restatements using ROW_NUMBER() window
--             partitioning to output exactly one authoritative record per fiscal period.
-- AUTHOR:  Data Analytics Portfolio
-- ENGINE:  Microsoft SQL Server (SSMS)
-- ===============================================================================

USE SEC_Financials;
GO

WITH RawFinancials AS (
    -- Step 1: Extract US-GAAP tags including Balance Sheet (qtrs=0) & Income Statement (qtrs=1,4)
    SELECT 
        s.name AS company_name,
        s.cik,
        s.fy AS fiscal_year,
        s.fp AS fiscal_period,
        s.form AS filing_form,
        n.ddate AS period_end_date,
        n.tag,
        n.value
    FROM dbo.sub s
    INNER JOIN dbo.num n 
        ON s.adsh = n.adsh
    WHERE s.cik IN (320193, 789019, 1318605)           -- CIKs: Apple Inc, Microsoft, Tesla
      AND s.form IN ('10-Q', '10-K')                    -- Official financial filings
      AND n.qtrs IN ('0', '1', '4')                     -- Balance sheet (0) & Income statement (1,4)
      AND n.uom = 'USD'                                 -- Normalize currency to USD
      AND n.tag IN (
          'NetIncomeLoss', 
          'Revenues', 
          'SalesRevenueNet', 
          'RevenueFromContractWithCustomerExcludingAssessedTax',
          'Assets', 
          'StockholdersEquity'
      )
),

PivotedMetrics AS (
    -- Step 2: Pivot vertical accounting line items into horizontal metric columns via conditional aggregation
    SELECT 
        company_name,
        cik,
        fiscal_year,
        fiscal_period,
        period_end_date,
        MAX(CASE WHEN tag = 'NetIncomeLoss' THEN value END) AS net_income,
        MAX(CASE WHEN tag IN ('Revenues', 'SalesRevenueNet', 'RevenueFromContractWithCustomerExcludingAssessedTax') THEN value END) AS revenue,
        MAX(CASE WHEN tag = 'Assets' THEN value END) AS total_assets,
        MAX(CASE WHEN tag = 'StockholdersEquity' THEN value END) AS total_equity
    FROM RawFinancials
    GROUP BY 
        company_name, 
        cik, 
        fiscal_year, 
        fiscal_period, 
        period_end_date
),

CalculatedRatios AS (
    -- Step 3: Format period dates, scale currency values into Billions ($B), and compute DuPont Ratios
    SELECT 
        company_name,
        fiscal_year,
        fiscal_period,
        -- Format YYYYMMDD string to standard YYYY-MM-DD Date
        CAST(
            STUFF(STUFF(period_end_date, 5, 0, '-'), 8, 0, '-') 
            AS DATE
        ) AS period_end_date,
        
        -- Currency Normalization: Convert raw USD amounts to Billions ($B) rounded to 2 decimal places
        ROUND(net_income / 1000000000.0, 2) AS net_income_billions,
        ROUND(revenue / 1000000000.0, 2) AS revenue_billions,
        ROUND(total_assets / 1000000000.0, 2) AS total_assets_billions,
        ROUND(total_equity / 1000000000.0, 2) AS total_equity_billions,

        -- DuPont Component 1: Net Profit Margin (Net Income / Revenue)
        ROUND(net_income / NULLIF(revenue, 0), 4) AS net_profit_margin,

        -- DuPont Component 2: Asset Turnover (Revenue / Total Assets)
        ROUND(revenue / NULLIF(total_assets, 0), 4) AS asset_turnover,

        -- DuPont Component 3: Equity Multiplier (Total Assets / Total Equity)
        ROUND(total_assets / NULLIF(total_equity, 0), 4) AS equity_multiplier,

        -- DuPont Return on Equity (ROE) = Profit Margin * Asset Turnover * Equity Multiplier
        ROUND(
            (net_income / NULLIF(revenue, 0)) * 
            (revenue / NULLIF(total_assets, 0)) * 
            (total_assets / NULLIF(total_equity, 0)), 
            4
        ) AS calculated_roe
    FROM PivotedMetrics
    WHERE net_income IS NOT NULL 
      AND revenue IS NOT NULL 
      AND total_assets IS NOT NULL 
      AND total_equity IS NOT NULL
),

DeduplicatedRatios AS (
    -- Step 4: Window Partitioning to rank multi-filings and isolate SEC restatements per period
    SELECT 
        *,
        ROW_NUMBER() OVER(
            PARTITION BY company_name, fiscal_year, fiscal_period 
            ORDER BY period_end_date DESC
        ) AS row_num
    FROM CalculatedRatios
)

-- Step 5: Final Deduplicated Portfolio Output (Filtering row_num = 1 keeps only latest filing)
SELECT 
    company_name,
    fiscal_year,
    fiscal_period,
    period_end_date,
    net_income_billions AS [net_income_($B)],
    revenue_billions AS [revenue_($B)],
    total_assets_billions AS [total_assets_($B)],
    total_equity_billions AS [total_equity_($B)],
    net_profit_margin,
    asset_turnover,
    equity_multiplier,
    calculated_roe
FROM DeduplicatedRatios
WHERE row_num = 1
ORDER BY 
    company_name, 
    period_end_date DESC;