-- Setup: Use or create a working database
USE DATABASE SNOWFLAKE_LEARNING_DB;

-- Step 1: Create a demo table  --22:54
CREATE OR REPLACE TABLE test_orders (
    id INT,
    status STRING
);

ALTER SESSION SET TIMEZONE = 'UTC';
SELECT CURRENT_TIMESTAMP(); 

-- 22:55 - Initial Insert
INSERT INTO test_orders VALUES (1, 'pending');

-- 22:58 - Update status
UPDATE test_orders SET status = 'shipped' WHERE id = 1;

-- Verify current state
SELECT * FROM test_orders;

-- Rewind: View data 1 minute before (approx. before update)
SELECT * FROM test_orders 
BEFORE (OFFSET => -60 * 3); 

--  - Insert another row
INSERT INTO test_orders VALUES (2, 'cancelled');

-- Check current table contents
SELECT * FROM test_orders;

--  - Delete the new row
DELETE FROM test_orders WHERE id = 2;

-- Time Travel to before delete
SELECT * FROM test_orders 
  AT (TIMESTAMP => '2025-06-21 23:02:00'); 

-- Scenario 1: Restore deleted row
INSERT INTO test_orders
SELECT * FROM test_orders AT (TIMESTAMP => '2025-06-21 23:02:00')
WHERE id = 2;

-- Confirm restoration
SELECT * FROM test_orders;

-- Scenario 2: Compare before/after update
-- Before update (5:58 AM)
SELECT * FROM test_orders 
  AT (TIMESTAMP => '2025-06-21 23:01:00');

-- Current state (after update)
SELECT * FROM test_orders;

-- Scenario 3: Create a backup clone from earlier state
CREATE OR REPLACE TABLE test_orders_backup CLONE test_orders 
  AT (TIMESTAMP => '2025-06-21 23:01:00');

-- View backup
SELECT * FROM test_orders_backup;

-- Scenario 4: Drop and recover the table
DROP TABLE test_orders;

-- Recover using UNDROP
UNDROP TABLE test_orders;

-- Final check
SELECT * FROM test_orders;
