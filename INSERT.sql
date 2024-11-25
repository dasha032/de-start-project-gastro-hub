/*Добавьте в этот файл запросы, которые наполняют данными таблицы в схеме cafe данными*/
INSERT INTO cafe.restaurants (
	cafe_name, 
	cafe_type, 
	menu)
SELECT DISTINCT m.cafe_name ,
	 	s."type" ::cafe.restaurant_type,
	 	m.menu
FROM raw_data.menu AS m
INNER JOIN (SELECT
			cafe_name,
			type 
			FROM raw_data.sales
			GROUP BY cafe_name, type) AS s ON(s.cafe_name = m.cafe_name);

		
INSERT INTO cafe.managers (
	manager ,
	manager_phone)
SELECT DISTINCT s.manager ,
		s.manager_phone 
FROM raw_data.sales s;


WITH work_periods AS (
    SELECT 
        restaurant_uuid,
        manager_uuid,
        MIN(report_date) AS date_start,
        MAX(report_date) AS date_finish
    FROM raw_data.sales s
    INNER JOIN cafe.managers m2 USING (manager)
    INNER JOIN cafe.restaurants r2 USING (cafe_name)
    GROUP BY restaurant_uuid, manager_uuid
)
INSERT INTO cafe.restaurant_manager_work_dates (restaurant_uuid, manager_uuid, date_start, date_finish)
SELECT
    wp.restaurant_uuid,
    wp.manager_uuid,
    wp.date_start,
    wp.date_finish
FROM work_periods wp;


INSERT INTO cafe.sales(
	restaurant_uuid,
	date,
	avg_check 
) 
SELECT r.restaurant_uuid,
		s.report_date,
		s.avg_check 
FROM raw_data.sales s
INNER JOIN cafe.restaurants r USING(cafe_name);
	
