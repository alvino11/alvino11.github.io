-- ===============================================================================
-- SCRIPT: indexing_and_verification.sql
-- PURPOSE: Apply clustered indexes to optimize join performance and audit counts.
-- ===============================================================================

USE SEC_Financials;
GO

-- Build clustered indexes on primary join keys 
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_sub_adsh')
BEGIN
    CREATE CLUSTERED INDEX IX_sub_adsh ON dbo.sub(adsh);
END;

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_num_adsh_tag')
BEGIN
    CREATE CLUSTERED INDEX IX_num_adsh_tag ON dbo.num(adsh, tag);
END;
GO

-- Audit total records loaded across the database
SELECT COUNT(*) AS total_submissions_loaded FROM dbo.sub;
SELECT COUNT(*) AS total_numeric_records_loaded FROM dbo.num;
GO