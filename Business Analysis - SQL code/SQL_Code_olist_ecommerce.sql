-- ------------------------------------------------------------------Customer Analysis----------------------------------------------------------------------
SELECT
    c.customer_state,
    c.customer_city,
    COUNT(*) AS total_customers
FROM customers AS c
GROUP BY
    c.customer_state,
    c.customer_city
ORDER BY
    total_customers DESC
LIMIT 10;

-- -------------------------------------------------------------------Sales Analysis ------------------------------------------------------------------------
-- Total Revenue of OLIST -- 
WITH total_revenue AS 
(
SELECT 
	o.order_purchase_timestamp,
	SUM(ot.price) AS Revenue
FROM orders AS o 
JOIN orders_items AS ot 
	ON ot.order_id = o.order_id 
GROUP BY 
	o.order_purchase_timestamp
),

-- Year Sales -- 
year_sales AS 
(
SELECT     
    DATE_FORMAT(order_purchase_timestamp, '%Y') AS Years,
    SUM(Revenue) AS total_sales_this_year
FROM total_revenue r
	GROUP BY DATE_FORMAT(order_purchase_timestamp, '%Y')
),
-- Monthly Sales --
monthly_sales AS 
(
SELECT 
	DATE_FORMAT(order_purchase_timestamp, '%M') AS Months,
    AVG(Revenue) AS monthly_revenue
FROM total_revenue
	GROUP BY DATE_FORMAT(order_purchase_timestamp, '%M')
)

SELECT * FROM monthly_sales;

-- Total Orders -- 
SELECT
    COUNT(*) AS total_completed_orders
FROM orders
WHERE order_status = 'delivered';

-- Average Order Value -- 
WITH total_sales AS 
(
SELECT 
	SUM(ot.price) AS Revenue,
    COUNT(DISTINCT order_id) AS total_complete_orders
FROM orders AS o
JOIN orders_items AS ot
ON ot.order_id = o.order_id 
WHERE order_status = 'DELIVERED'

)
SELECT 
	ROUND(Revenue / total_complete_orders,2) AS average_order_value
FROM total_sales;

-- ------------------------------------------------------------------Product Analysis ----------------------------------------------------------------------

-- Product Sold --
SELECT
    COUNT(*) AS total_products_sold
FROM orders_items;

-- Payment method generates high revenue -- 
SELECT
    op.payment_type,
    SUM(ot.price) AS sales
FROM order_payments op
JOIN orders_items ot
    ON op.order_id = ot.order_id
GROUP BY
    op.payment_type
ORDER BY
    sales DESC;
        
-- ------------------------------------------------------------------Seller Analysis ----------------------------------------------------------------------

-- Sellers Generated Highest Revenue -- 
SELECT 
	s.seller_id,
	SUM(ot.price) AS Sales ,
    DENSE_RANK()
    OVER (
		ORDER BY SUM(ot.price) DESC 
	) AS Rank_Sales
FROM orders_items ot
JOIN sellers s 
ON s.seller_id = ot.seller_id 
GROUP BY 
	s.seller_id;

-- States has the highest revenue -- 
SELECT 
	c.customer_state,
	SUM(ot.price) AS Revenue
FROM customers c 
JOIN orders o
ON c.customer_id = o.customer_id

JOIN orders_items ot
ON ot.order_id = o.order_id

GROUP BY 
	c.customer_state
ORDER BY 
	Revenue DESC
LIMIT 5;

-- ------------------------------------------------------------------Customer Satisfaction Analysis ----------------------------------------------------------------------

-- Aversge Customer Review Score -- 
SELECT
    ROUND(AVG(review_score), 2) AS average_review_score
FROM order_reviews;

-- Categories receive highest customer rating -- 
SELECT 
	p.product_category_name,
    ROUND(AVG(oe.review_score), 2) AS average_rating
FROM order_reviews oe
JOIN orders o
ON oe.order_id = o.order_id 

JOIN orders_items ot 
ON ot.order_id = o.order_id 

JOIN products p 
ON p.product_id = ot.product_id

GROUP BY 
	p.product_category_name
    
ORDER BY 
	average_rating DESC;
    
-- Delivery time results in lowercustomer reviews score -- 
SELECT
    CASE
        WHEN o.order_delivered_customer_date <= o.order_estimated_delivery_date
            THEN 'On Time'
        ELSE 'Late'
    END AS delivery_status,
    ROUND(AVG(oe.review_score),2) AS average_rating
FROM order_reviews oe
JOIN orders o
    ON o.order_id = oe.order_id
GROUP BY
    delivery_status;
    

    
