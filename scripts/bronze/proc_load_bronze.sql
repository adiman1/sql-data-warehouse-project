/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source CSV Files -> Bronze Schema)
===============================================================================

Script Purpose:
    This stored procedure automates the process of loading raw source data via FULL LOAD into the 
    'bronze' schema tables within the DataWarehouse database. It performs the following tasks:
    - Iterates through a predefined list of bronze tables and corresponding CSV file paths.
    - Truncates each target bronze table before loading to ensure data freshness.
    - Loads data efficiently using the BULK INSERT command from the specified CSV files.
    - Handles errors gracefully, logging success or failure status and error messages.
    - Logs load details into the 'bronze.etl_load_log' table, including timestamps, durations, 
      statuses, and error messages for audit and troubleshooting.

Parameters:
    None.
    This stored procedure does not accept any input parameters nor does it return any values.

Pre-requisites:
    - The target bronze tables must already exist within the DataWarehouse.bronze schema.
    - CSV files must be accessible from the SQL Server instance at the specified file paths.
    - The 'bronze.etl_load_log' table must exist to store load operation logs.

Usage Example:
    -- Execute the load process to refresh data in the bronze layer
    EXEC bronze.load_bronze;

===============================================================================
*/


USE DataWarehouse;
GO

CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE 
        @start_time DATETIME,
        @end_time DATETIME,
        @batch_start_time DATETIME,
        @batch_end_time DATETIME,
        @status NVARCHAR(50),
        @error_msg NVARCHAR(MAX),
        @table_name NVARCHAR(255),
        @file_path NVARCHAR(4000),
        @full_table_name NVARCHAR(500);

    SET @batch_start_time = GETDATE();

    PRINT '================================================';
    PRINT 'Loading Bronze Layer';
    PRINT '================================================';

    -- Temp table to hold tables and file paths to load
    DECLARE @LoadAndLog TABLE (
        table_name NVARCHAR(255),
        file_path NVARCHAR(4000)
    );

    INSERT INTO @LoadAndLog (table_name, file_path)
    VALUES 
        ('bronze.crm_cust_info', 'C:\sql\dwh_project\datasets\source_crm\cust_info.csv'),
        ('bronze.crm_prd_info', 'C:\sql\dwh_project\datasets\source_crm\prd_info.csv'),
        ('bronze.crm_sales_details', 'C:\sql\dwh_project\datasets\source_crm\sales_details.csv'),
        ('bronze.erp_loc_a101', 'C:\sql\dwh_project\datasets\source_erp\loc_a101.csv'),
        ('bronze.erp_cust_az12', 'C:\sql\dwh_project\datasets\source_erp\cust_az12.csv'),
        ('bronze.erp_px_cat_g1v2', 'C:\sql\dwh_project\datasets\source_erp\px_cat_g1v2.csv');

    DECLARE load_cursor CURSOR FOR 
        SELECT table_name, file_path FROM @LoadAndLog;

    OPEN load_cursor;
    FETCH NEXT FROM load_cursor INTO @table_name, @file_path;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        BEGIN TRY
            SET @start_time = GETDATE();
            SET @status = 'Success';
            SET @error_msg = NULL;

            -- Compose fully qualified table name with database.schema.table
            SET @full_table_name = QUOTENAME(DB_NAME()) + '.' + QUOTENAME(PARSENAME(@table_name, 2)) + '.' + QUOTENAME(PARSENAME(@table_name, 1));

            PRINT '------------------------------------------------';
            PRINT 'Loading Table: ' + @full_table_name;
            PRINT '------------------------------------------------';

            PRINT '>> Truncating Table: ' + @full_table_name;
            EXEC('TRUNCATE TABLE ' + @full_table_name);

            PRINT '>> Inserting Data From: ' + @file_path;
            EXEC('
                BULK INSERT ' + @full_table_name + '
                FROM ''' + @file_path + '''
                WITH (
                    FIRSTROW = 2,
                    FIELDTERMINATOR = '','',
                    ROWTERMINATOR = ''0x0A'',
                    TABLOCK
                );
            ');

            SET @end_time = GETDATE();

            PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        END TRY
        BEGIN CATCH
            SET @end_time = GETDATE();
            SET @status = 'Failure';
            SET @error_msg = ERROR_MESSAGE();

            PRINT '>> ERROR: ' + @error_msg;
        END CATCH;

        -- Insert log record
        INSERT INTO bronze.etl_load_log (
            table_name, file_path, load_start_time, load_end_time,
            duration_seconds, status, error_message, load_date
        )
        VALUES (
            @table_name, @file_path, @start_time, @end_time,
            DATEDIFF(SECOND, @start_time, @end_time),
            @status, @error_msg, CAST(@start_time AS DATE)
        );

        FETCH NEXT FROM load_cursor INTO @table_name, @file_path;
    END;

    CLOSE load_cursor;
    DEALLOCATE load_cursor;

    SET @batch_end_time = GETDATE();
    PRINT '==========================================';
    PRINT 'Bronze Layer Load Completed';
    PRINT '   - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
    PRINT '==========================================';
END;
GO
