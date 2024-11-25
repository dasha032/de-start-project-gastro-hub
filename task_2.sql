/*добавьте сюда запрос для решения задания 2*/
CREATE MATERIALIZED VIEW cafe.v_avg_ch_change AS
	WITH avg_ch AS (
		SELECT EXTRACT(YEAR FROM date) AS ext_year,
				ROUND(AVG(avg_check), 2) AS avg_check,
				restaurant_uuid
		FROM cafe.sales s 
		GROUP BY ext_year, restaurant_uuid
		HAVING EXTRACT(YEAR FROM date) <> EXTRACT(YEAR FROM CURRENT_DATE))
	SELECT ac.ext_year,
			r.cafe_name,
			r.cafe_type,
			ac.avg_check,
			LAG(ac.avg_check) OVER(PARTITION BY r.cafe_name ORDER BY  ac.ext_year) AS avg_check_prev,
			ROUND((ac.avg_check - LAG(ac.avg_check) OVER()) / avg_check * 100.0, 2) AS check_change
	FROM cafe.restaurants r 
	INNER JOIN avg_ch ac USING (restaurant_uuid);
			
