CREATE TABLE student.where_project (
                                       row_id int,
                                       order_id varchar(20),
                                       order_date varchar (15),
                                       ship_date varchar (15),
                                       ship_mode varchar (20),
                                       customer_id varchar (15),
                                       customer_name varchar (50),
                                       segment varchar (16),
                                       city varchar (100),
                                       state varchar (100),
                                       country varchar (40),
                                       postal_code varchar (15),
                                       market varchar (15),
                                       region varchar (20),
                                       product_id varchar (30),
                                       category varchar (20),
                                       sub_category varchar (20),
                                       product_name varchar (150),
                                       sales float,
                                       quantity int,
                                       discount float,
                                       profit float,
                                       shipping_cost float,
                                       order_priority varchar (15)

);

-- row_id
-- as int rather than smallint because we have more than 32,767 entries here

-- order_id
-- as varchar 20 as it is a variable length, 20 as this covers the general length with padding

-- order_date
-- as varchar 15 as max 10 with padding

-- ship_date
-- as varchar 15 as max 10 with padding

-- ship_mode
-- as varchar 20 as max 13 with padding

-- customer_id
-- as varchar 15 as max 8 with padding

-- customer_name
-- varchar 50 because both names together can be very long, padding

-- segment
-- as varchar 16 as max 12 with padding

-- city
-- as varchar 100 could be lots of different options, plus longest city name in the world is 85 characters, padding

-- state
-- as varchar 100 could be lots of different options, different definitions of state across the world, padding

-- country
-- as varchar 40 with padding

-- postal_code
-- as varchar 15 as no numeric calculations required on postal codes

-- market
-- as varchar 15 with padding

-- region
-- as  varchar 20 with padding

-- product_id
-- as varchar 30 as largest seen was less than 20, padding to be sure

-- category
-- as varchar 20, max was 16 plus padding

-- sub_category
-- as varchar 20, max was 12 plus padding, plus many more sub categories that we maybe couldn't see

-- product_name
-- varchar 150 max 127 with padding

-- sales
-- float as we have decimals but not always the same number of decimals

-- quantity
-- int as no decimals

-- discount
-- float as we have decimals but not always the same number of decimals

-- profit
-- float as we have decimals but not always the same number of decimals

-- shipping_cost
-- float as we have decimals but not always the same number of decimals

-- order_priority
-- varchar (15) as longest is critical with some space