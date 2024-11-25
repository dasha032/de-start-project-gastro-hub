/*добавьте сюда запрос для решения задания 5*/
WITH menu_cte AS (
    SELECT 
        cafe_name,
        (jsonb_each_text(menu->'Пицца')).key AS pizza_name,
        ((jsonb_each_text(menu->'Пицца')).value)::int AS pizza_price
    FROM cafe.restaurants
    WHERE cafe_type = 'pizzeria'
),
menu_with_rank AS (
	SELECT cafe_name,
			pizza_name,
			pizza_price,
			ROW_NUMBER() OVER(PARTITION BY cafe_name ORDER BY pizza_price DESC) AS rank
	FROM menu_cte
)
SELECT cafe_name,
		'Пицца' AS dish_type,
		pizza_name,
		pizza_price
FROM menu_with_rank
WHERE rank = 1
ORDER BY cafe_name

