# Write your MySQL query statement below
WITH performances as(SELECT e.employee_id,e.name,r.review_date,r.rating,ROW_NUMBER()OVER(PARTITION BY e.employee_id ORDER BY r.review_date desc) as n_review,
COUNT(*)over(PARTITION BY e.employee_id) as review_count
FROM employees e
JOIN performance_reviews r on r.employee_id=e.employee_id

)

SELECT p1.employee_id,
p1.name,
(p1.rating-p3.rating) as improvement_score
FROM performances p1

JOIN performances p2 on p2.employee_id=p1.employee_id and p2.n_review=2 and p1.rating>p2.rating
JOIN performances p3 on p3.employee_id=p1.employee_id and p3.n_review=3 and p2.rating>p3.rating
WHERE p1.n_review=1 and p1.review_count>=3
ORDER BY improvement_score desc,p1.name;
