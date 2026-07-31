-- ===============================================================================
-- PROJECT: SEC Financial Statement Analysis (DuPont Identity)
-- SCRIPT:  data_ingestion.sql
-- PURPOSE: Bulk load 8 quarters of SUB and NUM data using 0x0a hex line-feeds.
-- ===============================================================================

USE SEC_Financials;
GO

-- Empty staging tables before loading full dataset
TRUNCATE TABLE dbo.sub;
TRUNCATE TABLE dbo.num;
GO

-- List of local quarterly directories
DECLARE @Quarters TABLE (QtrFolder VARCHAR(10));
INSERT INTO @Quarters (QtrFolder) VALUES 
('2024q2'), ('2024q3'), ('2024q4'), ('2025q1'),
('2025q2'), ('2025q3'), ('2025q4'), ('2026q1');

DECLARE @Qtr VARCHAR(10);
DECLARE @SubPath NVARCHAR(500);
DECLARE @NumPath NVARCHAR(500);
DECLARE @Sql NVARCHAR(MAX);

-- Dynamic cursor to process each quarter folder
DECLARE qtr_cursor CURSOR FOR SELECT QtrFolder FROM @Quarters;
OPEN qtr_cursor;
FETCH NEXT FROM qtr_cursor INTO @Qtr;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @SubPath = N'C:\SEC_DATA\' + @Qtr + N'\sub.txt';
    SET @NumPath = N'C:\SEC_DATA\' + @Qtr + N'\num.txt';

    -- Bulk insert Submissions Metadata
    SET @Sql = N'
    BULK INSERT dbo.sub
    FROM ''' + @SubPath + '''
    WITH (
        FIELDTERMINATOR = ''\t'',
        ROWTERMINATOR = ''0x0a'',
        FIRSTROW = 2,
        CODEPAGE = ''65001'',
        MAXERRORS = 1000,
        TABLOCK
    );';
    EXEC sp_executesql @Sql;

    -- Bulk insert Numeric Values
    SET @Sql = N'
    BULK INSERT dbo.num
    FROM ''' + @NumPath + '''
    WITH (
        FIELDTERMINATOR = ''\t'',
        ROWTERMINATOR = ''0x0a'',
        FIRSTROW = 2,
        CODEPAGE = ''65001'',
        MAXERRORS = 1000,
        TABLOCK
    );';
    EXEC sp_executesql @Sql;

    FETCH NEXT FROM qtr_cursor INTO @Qtr;
END;

CLOSE qtr_cursor;
DEALLOCATE qtr_cursor;
GO