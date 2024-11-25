/*добавьте сюда запрос для решения задания 1*/
CREATE VIEW cafe.v_top_restaurants AS
WITH avg_ch AS (
    SELECT 
        restaurant_uuid,
        ROUND(AVG(avg_check), 2) AS avg_check
    FROM cafe.sales
    GROUP BY restaurant_uuid
),
ranked_restaurants AS (
    SELECT 
        r.cafe_name,
        r.cafe_type,
        ac.avg_check,
        ROW_NUMBER() OVER (PARTITION BY r.cafe_type ORDER BY ac.avg_check DESC) AS rank
    FROM avg_ch ac
    INNER JOIN cafe.restaurants r
    ON ac.restaurant_uuid = r.restaurant_uuid
)
SELECT 
    cafe_name,
    cafe_type,
    avg_check
FROM ranked_restaurants
WHERE rank <= 3;
