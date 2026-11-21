WITH CTE AS (
    SELECT *,
    COUNT(*) AS total_orders,
    ROUND(SUM(CASE WHEN (HOUR(order_timestamp) >= 11 AND HOUR(order_timestamp) < 14
OR HOUR(order_timestamp) >= 18 AND HOUR(order_timestamp) < 21) THEN 1 ELSE 0 END)*100/COUNT(*),0) AS peak_hour_percentage,
    ROUND(AVG(order_rating),2) as average_rating,
    SUM(CASE WHEN order_rating is NULL THEN 0 ELSE 1 END)/COUNT(*) AS rating_rate
    FROM restaurant_orders
    GROUP BY customer_id
)
SELECT customer_id,total_orders,peak_hour_percentage,average_rating FROM CTE
WHERE total_orders>=3
     AND peak_hour_percentage >= 60
     AND average_rating>=4
     AND rating_rate>=0.5
ORDER BY average_rating desc,customer_id desc;
       