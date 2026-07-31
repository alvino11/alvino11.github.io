-- ===============================================================================
-- PROJECT: SEC Financial Statement Analysis (DuPont Identity Pipeline)
-- SCRIPT:  schema_creation.sql
-- PURPOSE: Create target database and staging tables matching actual SEC layouts.
-- AUTHOR: Data Analytics Portfolio
-- ENGINE: Microsoft SQL Server (SSMS)
-- ===============================================================================

USE master;
GO

-- Create database if it does not exist
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'SEC_Financials')
BEGIN
    CREATE DATABASE SEC_Financials;
END;
GO

USE SEC_Financials;
GO

-- -------------------------------------------------------------------------------
-- TABLE 1: dbo.sub (Submissions Metadata)
-- Layout includes: baph, fye, form, period
-- -------------------------------------------------------------------------------
IF OBJECT_ID('dbo.sub', 'U') IS NOT NULL 
    DROP TABLE dbo.sub;
GO

CREATE TABLE dbo.sub (
    adsh        CHAR(20) NOT NULL,      -- SEC Accession Number (Primary Key)
    cik         INT NOT NULL,           -- Central Index Key (Company ID)
    name        VARCHAR(250) NULL,      -- Registered Company Name
    sic         VARCHAR(50) NULL,       -- Standard Industrial Classification Code
    countryba   VARCHAR(50) NULL,       -- Business Address Country
    stprba      VARCHAR(50) NULL,       -- Business Address State
    cityba      VARCHAR(100) NULL,      -- Business Address City
    zipba       VARCHAR(50) NULL,       -- Business Address ZIP Code
    bas1        VARCHAR(150) NULL,      -- Business Address Street Line 1
    bas2        VARCHAR(150) NULL,      -- Business Address Street Line 2
    baph        VARCHAR(50) NULL,       -- Business Address Phone Number
    countryma   VARCHAR(50) NULL,       -- Mailing Address Country
    stprma      VARCHAR(50) NULL,       -- Mailing Address State
    cityma      VARCHAR(100) NULL,      -- Mailing Address City
    zipma       VARCHAR(50) NULL,       -- Mailing Address ZIP Code
    mas1        VARCHAR(150) NULL,      -- Mailing Address Street Line 1
    mas2        VARCHAR(150) NULL,      -- Mailing Address Street Line 2
    countryinc  VARCHAR(50) NULL,       -- Country of Incorporation
    stprinc     VARCHAR(50) NULL,       -- State of Incorporation
    ein         VARCHAR(50) NULL,       -- IRS Employer ID
    former      VARCHAR(250) NULL,      -- Former Legal Name
    changed     VARCHAR(50) NULL,       -- Date of Name Change
    afs         VARCHAR(50) NULL,       -- Filer Status (e.g., 1-LAF)
    wksi        VARCHAR(50) NULL,       -- Well-Known Seasoned Issuer Flag
    fye         VARCHAR(50) NULL,       -- Fiscal Year-End (MMDD)
    form        VARCHAR(50) NULL,       -- Filing Form (10-K, 10-Q)
    period      VARCHAR(50) NULL,       -- Period End Date
    fy          VARCHAR(50) NULL,       -- Fiscal Year
    fp          VARCHAR(50) NULL,       -- Fiscal Period (Q1, Q2, Q3, FY)
    filed       VARCHAR(50) NULL,       -- Submission Date
    accepted    VARCHAR(50) NULL,       -- Acceptance Timestamp
    prevrpt     VARCHAR(50) NULL,       -- Previous Report Flag
    detail      VARCHAR(50) NULL,       -- Detail XBRL Flag
    instance    VARCHAR(100) NULL,      -- XBRL Document Filename
    nciks       VARCHAR(50) NULL,       -- Number of CIKs in Filing
    aciks       VARCHAR(MAX) NULL       -- Additional CIKs List
);
GO

-- -------------------------------------------------------------------------------
-- TABLE 2: dbo.num (Numeric Line Items)
-- Layout includes: segments
-- -------------------------------------------------------------------------------
IF OBJECT_ID('dbo.num', 'U') IS NOT NULL 
    DROP TABLE dbo.num;
GO

CREATE TABLE dbo.num (
    adsh        CHAR(20) NOT NULL,      -- Accession Number (Foreign Key -> sub)
    tag         VARCHAR(256) NOT NULL,  -- Standardized GAAP Accounting Tag
    version     VARCHAR(50) NOT NULL,   -- Accounting Taxonomy Release Version
    ddate       VARCHAR(50) NOT NULL,   -- Line Item Period Date
    qtrs        VARCHAR(50) NOT NULL,   -- Quarters Covered (1 = Quarter, 4 = Annual)
    uom         VARCHAR(50) NOT NULL,   -- Unit of Measure (e.g., USD)
    segments    VARCHAR(MAX) NULL,      -- Reporting Business Segments
    coreg       VARCHAR(256) NULL,      -- Co-registrant Entity
    value       DECIMAL(28, 4) NULL,    -- Quantitative Reported Dollar Amount
    footnote    VARCHAR(MAX) NULL       -- Footnote Text
);
GO