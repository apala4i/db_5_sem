-- 1
SELECT * FROM furniture
WHERE price > 4000
;

-- 2
SELECT * FROM furniture
WHERE price BETWEEN 1000 AND 2000
;

-- 3
SELECT * FROM users
WHERE email LIKE '%gmail.com'
;

-- 4
SELECT id FROM furniture AS f
WHERE f.fk_manufacturer IN (SELECT id from manufacturer WHERE distance < 500)
;

-- 5
SELECT id, name from users us
WHERE EXISTS(
	SELECT fk_user FROM user_order 
	WHERE fk_user = us.id
)
;

-- 6
SELECT fk_user FROM user_info
	WHERE birthday >= ALL (SELECT birthday FROM user_info)
;

-- 7
SELECT AVG(price) as "AVG_PRICE", COUNT(*), ft.name FROM furniture as f
JOIN furniture_type ft
ON ft.id = f.fk_furniture_type
GROUP BY fk_furniture_type, ft.name
;

-- 8
SELECT name, 
	(SELECT AVG(price) AVG_PRICE FROM furniture_type ft
	 JOIN furniture f
	 ON ft.id = f.fk_furniture_type
	 GROUP BY ft.id
	 HAVING ft.id = ftin.id
	),
	 (SELECT COUNT(*) QTY FROM furniture_type ft
	 JOIN furniture f
	 ON ft.id = f.fk_furniture_type
	 GROUP BY ft.id
	 HAVING ft.id = ftin.id)
FROM
	furniture_type ftin
;


-- 9
SELECT id,
	CASE ui.privileges_id
		WHEN 0 THEN 'poor'
		WHEN 1 THEN 'well'
		WHEN 2 THEN 'good'
		WHEN 3 THEN 'excellent'
	END as "priveleges_level"
FROM user_info ui
;

-- 10
SELECT id,
	CASE
		WHEN EXTRACT(YEAR FROM AGE(ui.birthday)) < 18 THEN 'young'
		WHEN EXTRACT(YEAR FROM AGE(ui.birthday)) > 18 THEN 'old'
		ELSE 'middle'
	END as age_level
FROM user_info ui
;

-- 11
SELECT COUNT(*), fk_furniture_type
INTO TEMP tmp_f
FROM furniture as f
GROUP BY f.fk_furniture_type
;

-- 12
SELECT name from
 (SELECT * from user_info
 WHERE EXTRACT(YEAR FROM AGE(birthday)) > 18) aged
 JOIN users u
 ON aged.fk_user = u.id
;

-- 13
SELECT name from users as uout
	WHERE id = (SELECT id
			   FROM users
			   WHERE LENGTH(email) = (SELECT MAX(LENGTH(email)) FROM users WHERE email LIKE '%@gmail.com')
			   AND email LIKE '%@gmail.com')

-- 14
SELECT p.name, COUNT(*) FROM user_info as ui
	JOIN privileges as p
	ON p.id = ui.privileges_id
GROUP BY p.name
;

-- 15
SELECT p.name, COUNT(*) FROM user_info as ui
	JOIN privileges as p
	ON p.id = ui.privileges_id
GROUP BY p.name
HAVING COUNT(*) > 30
;

-- 16
INSERT INTO USERS
	VALUES(9999, 'Fedor', 'apala4i', 'apala4igm@gmail.com', 'qweryIsTheBestPassword', 'Moscow')

-- 17
INSERT INTO order_furniture(fk_order, fk_furniture, qty)
SELECT 
	(SELECT(MAX(id)) FROM user_order),
	f.id,
	5 as qty
FROM furniture f
WHERE f.fk_furniture_type = 1;


-- 18
UPDATE furniture
SET price = 1000
WHERE id = 2
;

-- 19
UPDATE furniture
SET price = (SELECT MAX(price) FROM furniture WHERE fk_furniture_type = 1)
WHERE id = 9
;

-- 20
DELETE FROM furniture
WHERE price < 10
;

-- 21
DELETE FROM furniture
WHERE price <= ALL (SELECT AVG(price) * 0.001 FROM FURNITURE WHERE fk_furniture_type = 1)
;

-- 22
WITH oft AS (
	SELECT * FROM furniture f
	JOIN order_furniture o
	ON f.id = o.fk_furniture
	WHERE f.fk_furniture_type = 2
)
SELECT fk_order FROM oft
	JOIN user_order uo
		ON uo.id = oft.fk_order
	WHERE oft.price = (SELECT MAX(price) from oft)

-- 23
CREATE TABLE IF NOT EXISTS company(
    id int primary key,
    person_count int,
    building_name text,
    main_building int
)
;

INSERT INTO company
VALUES
    (1, 100, 'megaMain', NULL),
    (2, 230, 'simpleMain', 1),
    (3, 130, 'simpleMain2', 1),
    (4, 430, 'base', 2),
    (5, 1230, 'base2', 2),
    (6, 120, 'base3', 2),
    (7, 23, 'micro', 4),
    (8, 423, 'micro2', 4),
    (9, 23, 'micro3', 4),
    (10, 12, 'mirco4', 4)
;

WITH RECURSIVE ierarchy(id, person_count, building_name, main_building, depth) as (
	SELECT id, person_count, building_name, main_building, 1
		FROM company com
		WHERE com.id = 1
	
	UNION ALL
	
	SELECT com.id, com.person_count, com.building_name, com.main_building, depth + 1 depth
		FROM company com
			JOIN ierarchy i
				ON i.id = com.main_building
)
SELECT * FROM ierarchy
;

-- 24
SELECT DISTINCT ft.name,
	COUNT(*) OVER(PARTITION BY ft.name) as total_count,
	SUM(f.price) OVER(PARTITION BY ft.name ORDER BY f.price) as total_price,
	MIN(f.price) OVER(PARTITION BY ft.name ORDER BY f.price) as total_price,
	MAX(f.price) OVER(PARTITION BY ft.name ORDER BY f.price) as total_price,
	ROUND(AVG(f.discount) OVER(PARTITION BY ft.name), 2) as avg_discount
	 
	FROM furniture_type ft
		JOIN furniture f
			ON ft.id = f.fk_furniture_type
;

-- 25
WITH dup as (
	SELECT * FROM "privileges"
	UNION ALL
	SELECT * from "privileges"
	
), num as (
	SELECT *,
	ROW_NUMBER() OVER(PARTITION BY id) as ro_num
	FROM dup
)
SELECT * FROM num
WHERE ro_num = 1
;