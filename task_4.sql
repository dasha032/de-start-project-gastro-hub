/*добавьте сюда запрос для решения задания 4*/
WITH list_pizzas AS (
    SELECT 
        cafe_name,
        jsonb_each_text(menu->'Пицца') AS pizza_items
    FROM cafe.restaurants
    WHERE cafe_type = 'pizzeria'
),
pizza_counts AS (
    SELECT 
        cafe_name,
        COUNT(pizza_items) AS pizza_count
    FROM list_pizzas
    GROUP BY cafe_name
),
ranked_pizzerias AS (
    SELECT 
        cafe_name,
        pizza_count,
        DENSE_RANK() OVER (ORDER BY pizza_count DESC) AS rank
    FROM pizza_counts
)
SELECT 
    cafe_name,
    pizza_count
FROM ranked_pizzerias
WHERE rank = 1;
