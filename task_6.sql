/*добавьте сюда запросы для решения задания 6*/
BEGIN;
WITH updated_prices AS (
    SELECT 
        restaurant_uuid,
        ((menu->'Кофе'->'Капучино')::NUMERIC * 1.2)::text AS update_price --умножаем на 1.2, так как нужно увеличить цену на 20%
    FROM cafe.restaurants r 
    FOR UPDATE --Использую тип блокировки строк FOR UPDATE, чтобы предотвратить чтение и изменение данных выбранных строк, 
    			--пока блокировка активна
)
UPDATE cafe.restaurants r
SET menu = jsonb_set(
    menu,
    '{Кофе, Капучино}',--путь до цены
    ap.update_price::jsonb)
FROM updated_prices	ap
WHERE ap.restaurant_uuid = r.restaurant_uuid 
	AND menu->'Кофе' ? 'Капучино'; --проверяем, есть ли среди ключей верхнего уровня ключ "Капучино"
)
COMMIT;