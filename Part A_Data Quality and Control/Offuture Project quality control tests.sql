                                        -- GENERAL SELECT ALL DATA FROM TABLE --
SELECT
    *
FROM
    student.where_project_offuture;

------------------------------------------------------- PRE-CHECKS ----------------------------------------------------
                                                      -- Encoding --

-- We have asked the data provider for the encoding format of the data.
-- The data provider returned to us with the answer of Windows 1251,
-- which we changed in the settings while importing the data.

------------------------------------------------------- CHECKS ---------------------------------------------------------

                                             -- Rows and Column Matching --

-- CHECK 1 -- Number of Rows
SELECT
    count(*)
FROM
    student.where_project_offuture;
-- Number of rows in Excel = 51290 (PASS)



-- CHECK 2 Distinct Row ID --
SELECT
    count(DISTINCT row_id)
FROM
    student.where_project_offuture;
-- Number of rows in Excel = 51290 (PASS)
-- Matches row id count so no duplicates



-- CHECK 3 Number of Columns --
SELECT
    count(*) AS column_count
FROM
    information_schema.columns
WHERE
    table_name = 'where_project_offuture';
-- In Excel there are 24 Columns, 24 in SQL (PASS)



-- CHECK 4 Column Names --
SELECT
    column_name
FROM
    information_schema.columns
WHERE
    table_name = 'where_project_offuture';
-- Eyeball check match with Excel (See Below)  (PASS)
-- row id
-- order id
-- order date
-- ship date
-- ship mode
-- customer id
-- customer name
-- segment
-- city
-- state
-- country
-- postal code
-- market
-- region
-- product id
-- category
-- sub category
-- product name
-- sales
-- quantity
-- discount
-- profit
-- shipping cost
-- order priority


                                                  -- Column Calculations --

-- CHECK 5 -- SUM Sales
SELECT
    SUM(sales)
FROM
    student.where_project_offuture;
-- Sales SUM in Excel = 12642501.91 (PASS)



-- CHECK 6 -- SUM Discount
SELECT
    SUM(discount)
FROM
    student.where_project_offuture;
-- Discount SUM in Excel = 7329.728 (PASS)



-- CHECK 7 -- SUM Shipping Costs
SELECT
    SUM(shipping_cost)
FROM
    student.where_project_offuture;
-- Shipping Cost SUM in Excel = 1352820.69 (PASS)



-- CHECK 8 -- SUM Profit
SELECT
    sum(profit)
FROM
    student.where_project_offuture;
-- Profit SUM in Excel = 1467457.291 (PASS)



-- CHECK 9 -- SUM Quantity
SELECT
    sum(quantity)
FROM
    student.where_project_offuture;
-- Quantity SUM in Excel = 178312 (PASS)



-- CHECK 10 -- SUM Row ID
SELECT
    sum(row_id)
FROM
    student.where_project_offuture;
-- Row ID SUM in Excel = 1315357695 (PASS)



-- CHECK 11 -- SUM Postal Code
SELECT
    sum(postal_code::int)
FROM
    student.where_project_offuture;
-- Postal Code SUM in Excel = 551572652 (PASS)



-- CHECK 12 Max Row ID
SELECT
    MAX(row_id)
FROM
    student.where_project_offuture;
-- Excel max Row ID = 51290 (PASS)

                                    -- Truncation Testing --

-- CHECK 13 -- Code for the max length of each column to check for truncation --
SELECT
    max(length(order_id)) as max_order_id_length,
    max(length(order_date)) as max_order_date_length,
    max(length(ship_date)) as max_ship_date_length,
    max(length(ship_mode)) as max_ship_mode_length,
    max(length(customer_id)) as max_customer_id_length,
    max(length(customer_name)) as max_customer_name_length,
    max(length(segment)) as max_segment_length,
    max(length(city)) as max_city_length,
    max(length(state)) as max_state_length,
    max(length(country)) as max_country_length,
    max(length(postal_code)) as max_postal_code_length,
    max(length(market)) as max_market_length,
    max(length(region)) as max_region_length,
    max(length(product_id)) as max_product_id_length,
    max(length(category)) as max_category_length,
    max(length(sub_category)) as max_sub_category_length,
    max(length(product_name)) as max_product_name,
    max(length(order_priority)) as max_order_priority_length
FROM
    student.where_project_offuture;
-- All max values are under the max setting for the column (see below) (PASS)
-- order_id varchar(20),
-- order_date varchar (15),
-- ship_date varchar (15),
-- ship_mode varchar (20),
-- customer_id varchar (15),
-- customer_name varchar (50),
-- segment varchar (16),
-- city varchar (100),
-- state varchar (100),
-- country varchar (40),
-- postal_code varchar (15),
-- market varchar (15),
-- region varchar (20),
-- product_id varchar (30),
-- category varchar (20),
-- sub_category varchar (20),
-- product_name varchar (150),
-- order_priority varchar (15)

                            -- Data Types --

-- CHECK 14 For Data Types

-- Original check that data types are correct in every row and column.
SELECT
    count(*),
    pg_typeof(row_id) AS row_id_type,
    pg_typeof(order_id) AS order_id_type,
    pg_typeof(order_date) AS order_date_type,
    pg_typeof(ship_date) AS ship_date_type,
    pg_typeof(ship_mode) AS ship_mode_type,
    pg_typeof(customer_id) AS customer_id_type,
    pg_typeof(customer_name) AS customer_name_type,
    pg_typeof(segment) AS segment_type,
    pg_typeof(city) AS city_type,
    pg_typeof(state) AS state_type,
    pg_typeof(country) AS country_type,
    pg_typeof(postal_code) AS postal_code_type,
    pg_typeof(market) AS market_type,
    pg_typeof(region) AS region_type,
    pg_typeof(product_id) AS product_id_type,
    pg_typeof(category) AS category_type,
    pg_typeof(sub_category) AS sub_category_type,
    pg_typeof(product_name) AS product_name_type,
    pg_typeof(sales) AS sales_type,
    pg_typeof(quantity) AS quantity_type,
    pg_typeof(discount) AS discount_type,
    pg_typeof(profit) AS profit_type,
    pg_typeof(shipping_cost) AS shipping_cost_type,
    pg_typeof(order_priority) AS order_priority_type
FROM
    student.where_project_offuture
GROUP BY
    row_id_type,
    order_id_type,
    order_date_type,
    ship_date_type,
    ship_mode_type,
    customer_name_type,
    customer_id_type,
    segment_type,
    city_type,
    state_type,
    country_type,
    postal_code_type,
    market_type,
    region_type,
    product_id_type,
    category_type,
    sub_category_type,
    product_name_type,
    sales_type,
    quantity_type,
    discount_type,
    profit_type,
    shipping_cost_type,
    order_priority_type;



-- CHECK 15

-- Second check that data type is correct across columns
SELECT
    column_name,
    data_type
FROM
    information_schema.columns
WHERE
    table_name = 'where_project_offuture';
-- All columns have the correct data types, SUMs performed accurately on int and float types
-- Strings recorded as varchar type

                        -- Special Characters --

-- CHECK 16

-- Initial search for customer names with special characters:
SELECT
    distinct customer_name
FROM
    student.where_project_offuture
WHERE
    customer_name ~ '[^a-zA-Z0-9 ]'
ORDER BY
    customer_name;

-- We found that there are a few names where the characters have not been correctly transported
-- Resi Polking, Anna Haberlin, Neil Franzusisch, Roy Franzusisch, Barry Franzusisch and Peter Bahler
-- Below is that search showing them:

-- CHECK 17
SELECT
    distinct customer_name
FROM
    student.where_project_offuture
WHERE
        customer_name ~ '[^a-zA-Z0-9 '' -]'
ORDER BY
    customer_name;



-- CHECK 18
-- Checking that this INCORRECT translation is CONSISTENT
SELECT customer_name,
       count(*)
FROM
    student.where_project_offuture
WHERE
    customer_name like '%Resi%'
GROUP BY
    customer_name;

-- Also, three customers: Corey-Lock, Jason Fortune and Joy Bell. Have unnecessaryily placed dashes in their names
-- But this is present in the Excel data, assuming data entry mistake
-- Here is the search for them:



-- CHECK 19
SELECT
    distinct customer_name
FROM
    student.where_project_offuture
WHERE
        customer_name like '%-%';

-- There are Irish names with apostrophes which match the Excel database:



-- CHECK 20
SELECT
    distinct customer_name
FROM
    student.where_project_offuture
WHERE
        customer_name like '%''%';



-- CHECK 21 Product Name
SELECT
    distinct product_name
FROM
    student.where_project_offuture
WHERE
    product_name ~ '[0-9 ''-,"/.&x£%#]'
ORDER BY
    product_name DESC;
-- Check that all the special characters have come through (PASS)

                          -- Eyeball check --

-- CHECK 22 First 20 Rows
SELECT
    *
FROM
    student.where_project_offuture
LIMIT
    20;
-- Eyeball check visually performed with random sample, nothing of note apart from null values for postal codes outside of US (PASS)



-- CHECK 23 Random Row Check 1
SELECT
    *
FROM
    student.where_project_offuture
WHERE
    row_id = 16343;
-- Excel data matches and confirms with SQL etc (PASS)



-- CHECK 24 Random Row Check 2
SELECT
    *
FROM
    student.where_project_offuture
 WHERE
    row_id = 11844;
-- Excel data matches and confirms with SQL etc (PASS)

                         -- Download Compare --

-- CHECK 25

-- Exported data into csv file
-- Checked number of rows in original csv data to exported csv data were the same
-- Check random rows were equivelent
-- All 24 columns were the same
-- (PASS)

                            -- Null Count --

-- CHECK 26 Searching for any row with null
SELECT
    *
FROM
    student.where_project_offuture
WHERE
    row_id is null or order_id is null or order_date is null or ship_date is null
    or ship_mode is null or customer_id is null or customer_name is null or segment is null
    or city is null or state is null or country is null or postal_code is null or market is null
    or region is null or product_id is null or category is null or sub_category is null or product_name is null
    or product_name is null or sales is null or quantity is null or discount is null or profit is null
    or shipping_cost is null or order_priority is null;
-- Non US addresses do not have postal codes in Excel data so will always return null (PASS)



-- CHECK 27 Searching for any with null excluding postal code
SELECT
    *
FROM
    student.where_project_offuture
WHERE
    row_id is null or order_id is null or order_date is null or ship_date is null
   or ship_mode is null or customer_id is null or customer_name is null or segment is null
   or city is null or state is null or country is null or market is null
   or region is null or product_id is null or category is null or sub_category is null or product_name is null
   or product_name is null or sales is null or quantity is null or discount is null or profit is null
   or shipping_cost is null or order_priority is null;
-- No other columns have null values (PASS)



-- CHECK 28 Checking Postal code null count
SELECT
    count(*),
    postal_code
FROM
    student.where_project_offuture
WHERE
    postal_code is null
GROUP BY
    postal_code;
-- In Excel there are 41296 nulls which matches (PASS)

                              -- SINGLE CUSTOMER VIEW --

-- Find customer records with multiple purchases:
SELECT
    count(*),
    customer_id
FROM
    student.where_project_offuture
GROUP BY
    customer_id
HAVING count(*) < 10;

-- Bring up all the rows for selected customer EB-3870:
SELECT
    *
FROM
    student.where_project_offuture
WHERE
        customer_id = 'EB-3870';

-- Create table with desired rows:
CREATE TABLE student.where_project_scv

(
    customer_id int,
    customer_name varchar (50),
    different_locations int,
    product_categories varchar (100),
    quantity int,
    total_sales float,
    profit float
);

-- Insert required data into table:
INSERT INTO student.where_project_scv
(customer_id, customer_name, different_locations, product_categories, quantity, total_sales, profit)
VALUES
    (46996, 'Emily Burns', 5, 'Office Supplies, Furniture, Technology', 8, 184.87, -166.82);

-- Summon Single Customer View Table:
SELECT
    *
FROM
    student.where_project_scv;

---------------------------------------------------- END ---------------------------------------------------------------