/*Добавьте в этот файл все запросы, для создания схемы сafe и
 таблиц в ней в нужном порядке*/
CREATE SCHEMA IF NOT EXISTS cafe;

CREATE TYPE cafe.restaurant_type AS ENUM('coffee_shop', 'restaurant', 'bar', 'pizzeria');

CREATE TABLE cafe.restaurants (
	restaurant_uuid UUID PRIMARY KEY DEFAULT GEN_RANDOM_UUID(),
	cafe_name VARCHAR,
	cafe_type cafe.restaurant_type,
	menu JSONB
);

CREATE TABLE cafe.managers (
	manager_uuid UUID PRIMARY KEY DEFAULT GEN_RANDOM_UUID(),
	manager VARCHAR,
	manager_phone VARCHAR
);

CREATE TABLE cafe.restaurant_manager_work_dates (
	restaurant_uuid UUID DEFAULT GEN_RANDOM_UUID(),
	manager_uuid UUID DEFAULT GEN_RANDOM_UUID(),
	date_start DATE,
	date_finish DATE,
	PRIMARY KEY(restaurant_uuid, manager_uuid)
);

CREATE TABLE cafe.sales(
	date DATE,
	restaurant_uuid UUID DEFAULT GEN_RANDOM_UUID(),
	avg_check NUMERIC(6, 2),
	PRIMARY KEY(date, restaurant_uuid)
);