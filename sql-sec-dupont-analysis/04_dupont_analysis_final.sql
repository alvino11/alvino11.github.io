-- ===============================================================================
-- PROJECT: SEC Financial Statement Analysis (DuPont Identity)
-- SCRIPT:  dupont_analysis_final.sql
-- PURPOSE: Compute DuPont Ratios including Balance Sheet (qtrs=0) & Income tags.
-- ===============================================================================

USE SEC_Financials;
GO

WITH RawFinancials AS (
    -- Extract US-GAAP tags including Balance Sheet (qtrs=0) & Income Statement (qtrs=1,4)
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
    WHERE s.cik IN (320193, 789019, 1318605, 1418121)    -- Apple, MSFT, Tesla, Apple Hospitality REIT
      AND s.form IN ('10-Q', '10-K')                   -- Official filings
      AND n.qtrs IN ('0', '1', '4')                     -- Includes 0 for Balance Sheet (Assets/Equity)
      AND n.uom = 'USD'                                -- Restrict to USD
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
    -- Step 2: Pivot vertical line item tags into horizontal metric columns
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
)

-- Step 3: Compute 3-Step DuPont Ratios & Return on Equity (ROE)
SELECT 
    company_name,
    fiscal_year,
    fiscal_period,
    period_end_date,
    
    -- Absolute Currency Figures
    net_income,
    revenue,
    total_assets,
    total_equity,

    -- Ratio 1: Net Profit Margin (Profitability Efficiency)
    ROUND(net_income / NULLIF(revenue, 0), 4) AS net_profit_margin,

    -- Ratio 2: Asset Turnover (Asset Utilization Efficiency)
    ROUND(revenue / NULLIF(total_assets, 0), 4) AS asset_turnover,

    -- Ratio 3: Equity Multiplier (Financial Leverage)
    ROUND(total_assets / NULLIF(total_equity, 0), 4) AS equity_multiplier,

    -- Calculated Return on Equity (ROE)
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
ORDER BY 
    company_name, 
    period_end_date DESC;