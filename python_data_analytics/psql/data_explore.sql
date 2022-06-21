-- Show table schema
\d+ retail;

-- Show first 10 rows of the table
SELECT *
FROM retail
LIMIT 10;

-- Check # of records
SELECT
    COUNT(*)
FROM retail;

-- Number of clients (e.g. unique client ID)
SELECT
    COUNT(DISTINCT customer_id)
FROM retail;

-- Invoice date range (e.g. max/min dates)
SELECT
    MIN(invoice_date),
    MAX (invoice_date)
FROM retail;

-- Number of SKU/merchants (e.g. unique stock code)
SELECT
    COUNT(DISTINCT stock_code)
FROM retail;

-- Calculate average invoice amount excluding invoices with a negative amount
SELECT AVG(a.Average_amount)
FROM (
    SELECT SUM(unit_price*quantity) AS Average_amount
    FROM retail
    GROUP BY invoice_no
    HAVING  SUM(unit_price*quantity) > 0
    ) AS a;

-- Calculate total revenue
SELECT
    SUM(unit_price * quantity)
FROM retail;

-- Calculate total revenue by YYYYMM
 SELECT
    to_char(invoice_date, 'YYYYMM')::integer AS YYYYMM,
    SUM(unit_price * quantity)
 FROM retail
 GROUP BY YYYYMM
 ORDER BY YYYYMM;
