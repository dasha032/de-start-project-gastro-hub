/*добавьте сюда запрос для решения задания 3*/
WITH top_rest_manager AS (
	SELECT restaurant_uuid,
		COUNT(manager_uuid) OVER(PARTITION BY restaurant_uuid) AS changes_managers
	FROM cafe.restaurant_manager_work_dates rmwd 
)
SELECT DISTINCT r.cafe_name,
		tr.changes_managers
FROM cafe.restaurants r 
INNER JOIN top_rest_manager tr USING(restaurant_uuid)
ORDER BY tr.changes_managers DESC
LIMIT 3;