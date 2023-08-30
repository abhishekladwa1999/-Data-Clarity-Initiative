SELECT
    *
FROM
    student.where_project_offuture
ORDER BY
    order_date;

SELECT
    row_id,
    order_id,
    order_date,
    ship_date,
    customer_name,
    market,
    product_id,
    product_name,
    sales,
    profit,
    shipping_cost

FROM
    student.where_project_offuture;



SELECT
    sum(sales)
FROM
    student.where_project_offuture
WHERE
    order_date like '%11';

SELECT
    sum(sales)
FROM
    student.where_project_offuture
WHERE
        order_date like '%12';

SELECT
    sum(sales)
FROM
    student.where_project_offuture
WHERE
        order_date like '%13';

SELECT
    sum(sales)
FROM
    student.where_project_offuture
WHERE
        order_date like '%14';

--2259450.8955399944 (2011 total sales)
--2677438.6943999785 (2012 total sales)
--3405746.449379987  (2013 total sales)
--4299865.870559989  (2014 total sales)

SELECT
    market,
    country,
    sum(sales)
FROM
    student.where_project_offuture
WHERE
    market = 'APAC' and order_date like '%11'
GROUP BY
    market,
    country
ORDER BY
    sum(sales) desc;

SELECT
    market,
    country,
    sum(sales)
FROM
    student.where_project_offuture
WHERE
        market = 'APAC' and order_date like '%12'
GROUP BY
    market,
    country
ORDER BY
    sum(sales) desc;

SELECT
    market,
    country,
    sum(sales)
FROM
    student.where_project_offuture
WHERE
        market = 'APAC' and order_date like '%13'
GROUP BY
    market,
    country
ORDER BY
    sum(sales) desc;

SELECT
    market,
    country,
    sum(sales)
FROM
    student.where_project_offuture
WHERE
        market = 'APAC' and order_date like '%14'
GROUP BY
    market,
    country
ORDER BY
    sum(sales) desc;

SELECT
    market,
    (sum(profit)/sum(sales) * 100) as profit_margin
FROM
    student.where_project_offuture
GROUP BY
    market
ORDER BY
    profit_margin DESC;

SELECT
    sub_category,
    sum (sales)
FROM
    student.where_project_offuture
GROUP BY
    sub_category;

SELECT
    sub_category,
    sum (sales)
FROM
    student.where_project_offuture
WHERE
    order_date like '%11'
GROUP BY
    sub_category;

SELECT
    sub_category,
    sum (sales)
FROM
    student.where_project_offuture
WHERE
        order_date like '%12'
GROUP BY
    sub_category;

SELECT
    sub_category,
    sum (sales)
FROM
    student.where_project_offuture
WHERE
        order_date like '%13'
GROUP BY
    sub_category;

SELECT
    sub_category,
    sum (sales)
FROM
    student.where_project_offuture
WHERE
        order_date like '%14'
GROUP BY
    sub_category;


SELECT MAX(max_profit)
FROM (
         SELECT SUM(profit) AS max_profit
         FROM student.where_project_offuture
         WHERE order_date LIKE '%2011%'

         UNION ALL

         SELECT SUM(profit) AS max_profit
         FROM student.where_project_offuture
         WHERE order_date LIKE '%2012%'

         UNION ALL

         SELECT SUM(profit) AS max_profit
         FROM student.where_project_offuture
         WHERE order_date LIKE '%2013%'

         UNION ALL

         SELECT SUM(profit) AS max_profit
         FROM student.where_project_offuture
         WHERE order_date LIKE '%2014%'
     ) AS sub_query;


SELECT
    subcat13.sub_category,
    sum_sales_2013,
    sum_sales_2014,
    ((sum_sales_2014 - sum_sales_2013)/sum_sales_2014 * 100) as perc_change
FROM
    (SELECT
         sub_category,
         sum(sales) as sum_sales_2013
     FROM
         student.where_project_offuture
     WHERE
             order_date like '%2013%'
     GROUP BY
         sub_category) AS subcat13
        JOIN (SELECT
                  sub_category,
                  sum(sales) as sum_sales_2014
              FROM
                  student.where_project_offuture
              WHERE
                      order_date like '%2014%'
              GROUP BY
                  sub_category) AS subcat14 on subcat14.sub_category = subcat13.sub_category
ORDER BY
    perc_change DESC;

SELECT
    t1.product_id,
    t1.sum_sales_2013,
    t2.sum_sales_2014,
    CASE
        WHEN t2.sum_sales_2014 > t1.sum_sales_2013 THEN 'Growth'
        WHEN t2.sum_sales_2014 < t1.sum_sales_2013 THEN 'Decline'
        ELSE 'No Change'
        END AS growth_status
FROM
    (SELECT
         product_id,
         SUM(sales) AS sum_sales_2013
     FROM
         student.where_project_offuture
     WHERE
             order_date LIKE '%2013%'
     GROUP BY
         product_id) AS t1
        INNER JOIN
    (SELECT
         product_id,
         SUM(sales) AS sum_sales_2014
     FROM
         student.where_project_offuture
     WHERE
             order_date LIKE '%2014%'
     GROUP BY
         product_id) AS t2
    ON
            t1.product_id = t2.product_id;

SELECT
    discount,
    profit
FROM
    student.where_project_offuture
ORDER BY
    discount desc;

SELECT
    cat11.category,
    sum_sales_2011,
    sum_sales_2012,
    ((sum_sales_2012-sum_sales_2011/sum_sales_2011 * 100) as perc_change
FROM
    (SELECT
         category,
         sum(sales) as sum_sales_2011
     FROM
         student.where_project_offuture
     WHERE
             order_date like '%2011%'
     GROUP BY
         category) AS cat11
        JOIN (SELECT
                  category,
                  sum(sales) as sum_sales_2012
              FROM
                  student.where_project_offuture
              WHERE
                      order_date like '%2012%'
              GROUP BY
                  category) AS cat14 on cat14.category = cat13.category
ORDER BY
    perc_change DESC;

SELECT
    category,
    ((sum(sales) FILTER (WHERE order_date LIKE '%2012%') - sum(sales) FILTER (WHERE order_date LIKE '%2011%')) / sum(sales) FILTER (WHERE order_date LIKE '%2011%') * 100) AS perc_change_2011_to_2012,
    ((sum(sales) FILTER (WHERE order_date LIKE '%2013%') - sum(sales) FILTER (WHERE order_date LIKE '%2012%')) / sum(sales) FILTER (WHERE order_date LIKE '%2012%') * 100) AS perc_change_2012_to_2013,
    ((sum(sales) FILTER (WHERE order_date LIKE '%2014%') - sum(sales) FILTER (WHERE order_date LIKE '%2013%')) / sum(sales) FILTER (WHERE order_date LIKE '%2013%') * 100) AS perc_change_2013_to_2014
FROM
    student.where_project_offuture
WHERE
        order_date LIKE '%2011%' OR
        order_date LIKE '%2012%' OR
        order_date LIKE '%2013%' OR
        order_date LIKE '%2014%'
GROUP BY
    category
ORDER BY
    category;



SELECT
    product_id,
    discount,
    sum(profit)
FROM
    student.where_project_offuture
GROUP BY
    product_id,
    discount,
    profit


SELECT
    discount,
    sum(profit) as total_profit
FROM
    student.where_project_offuture
GROUP BY
    discount
ORDER BY
    discount;



SELECT
    product_id,
    product_name,
    SUM(quantity) AS qty
FROM
    student.where_project_offuture
GROUP BY
    product_id,
    product_name
ORDER BY
    qty DESC, product_id
LIMIT 1;



SELECT
    order_date,
    sales
FROM
    student.where_project_offuture
WHERE
    order_date like '%2014' - '%2011'
ORDER BY
    order_date;

SELECT max_profit, year
FROM (
         SELECT SUM(profit) AS max_profit, '2011' AS year
         FROM student.where_project_offuture
         WHERE order_date LIKE '%2011%'

         UNION ALL

         SELECT SUM(profit) AS max_profit, '2012' AS year
         FROM student.where_project_offuture
         WHERE order_date LIKE '%2012%'

         UNION ALL

         SELECT SUM(profit) AS max_profit, '2013' AS year
         FROM student.where_project_offuture
         WHERE order_date LIKE '%2013%'

         UNION ALL

         SELECT SUM(profit) AS max_profit, '2014' AS year
         FROM student.where_project_offuture
         WHERE order_date LIKE '%2014%'
     ) AS sub_query
ORDER BY max_profit DESC
LIMIT 1;

SELECT
    product_id, SUM(profit) max_profit, product_name
FROM
    student.where_project_offuture
GROUP BY
    product_id,
    product_name
ORDER BY
    max_profit DESC
LIMIT 10;

-- Top 10 Least Profitable Products

SELECT
    product_id, SUM(profit) max_profit, product_name
FROM
    student.where_project_offuture
GROUP BY
    product_id,
    product_name
ORDER BY
    max_profit desc
LIMIT 10;

select sum(prof)
from
    (select
         product_name, sum(profit) prof
     from
         student.where_project_offuture
     where
             sub_category = 'Tables'
     group by
         product_name
     having
             sum(profit) > 0
     order by
         prof) as sub_query;