/*добавьте сюда запросы для решения задания 6*/
BEGIN;
LOCK TABLE cafe.managers IN EXCLUSIVE MODE; --Использую тип блокировки таблицы EXCLUSIVE, так как нужно ограничить
											-- изменение данных, но оставить возможность чтения

ALTER TABLE cafe.managers ADD COLUMN phone_array TEXT[];

WITH ranked_managers AS (
    SELECT 
        manager_uuid,
        manager_phone,
        ROW_NUMBER() OVER (ORDER BY manager) + 99 AS rank --так как поряжковый номер начинается со 100
    FROM cafe.managers
)
UPDATE cafe.managers m
SET phone_array = ARRAY[
        CONCAT('8-800-2500-', rm.rank::TEXT),--новый телефон
        rm.manager_phone --старый телефон
    ]
FROM ranked_managers rm
WHERE m.manager_uuid = rm.manager_uuid;

ALTER TABLE cafe.managers DROP COLUMN manager_phone;--удаление поля со старым телефоном

COMMIT;